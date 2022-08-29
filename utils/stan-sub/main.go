// Copyright 2016-2019 The NATS Authors
// Modifications Copyright 2021 Eric Lee (elee@kududyn.com)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package main

import (
	"encoding/json"
	"flag"
	"os"
	"os/signal"
	"sync"
	"time"

	log "github.com/sirupsen/logrus"
	nats "github.com/nats-io/nats.go"
	stan "github.com/nats-io/stan.go"
	"github.com/willf/bitset"
)

const usageStr = `
Usage: stan-sub [options] <subject>

Options:
    -s,  --server   <url>            NATS Streaming server URL(s)
    -c,  --cluster  <cluster name>   NATS Streaming cluster name
    -id, --clientid <client ID>      NATS Streaming client ID
    -cr, --creds    <credentials>    NATS 2.0 Credentials
    --quiet                          Disable logging

Subscription Options:
    --first    <seqno>               Start at seqno
    --last     <seqno>               End at seqno
`

var (
	// Configuration variables.
	clusterID, clientID string
	URL                 string
	userCreds           string
	startSeq            uint64
	endSeq              uint64
	subject             string
	quiet               bool

	// Connection variables.
	nc  *nats.Conn
	sc  stan.Conn
	sub stan.Subscription

	// Runtime controls.
	done         chan bool
	finished     bool
	idle_timeout time.Duration
	last_time    time.Time
	seen         *bitset.BitSet
	seen_mutex   sync.Mutex
)

// NOTE: Use tls scheme for TLS, e.g. stan-sub -s tls://demo.nats.io:4443 foo
func usage() {
	log.Fatal(usageStr)
}

func initialize() {
	done = make(chan bool, 1)
	idle_timeout = 5 * time.Second
	last_time = time.Now()
	// Assumption: the set of messages to watch for is small
	seen = bitset.New(uint(endSeq - startSeq + 1))
}

func finish() bool {
	already_finished := finished
	finished = true
	select {
	case done <- true:
	default:
	}
	return !already_finished
}

func configure() {
	flag.StringVar(&URL, "s", stan.DefaultNatsURL, "The nats server URLs (separated by comma)")
	flag.StringVar(&URL, "server", stan.DefaultNatsURL, "The nats server URLs (separated by comma)")
	flag.StringVar(&clusterID, "c", "test-cluster", "The NATS Streaming cluster ID")
	flag.StringVar(&clusterID, "cluster", "test-cluster", "The NATS Streaming cluster ID")
	flag.StringVar(&clientID, "id", "stan-sub", "The NATS Streaming client ID to connect with")
	flag.StringVar(&clientID, "clientid", "stan-sub", "The NATS Streaming client ID to connect with")
	flag.BoolVar(&quiet, "quiet", false, "Disable logging")
	// Subscription options
	flag.Uint64Var(&startSeq, "first", 0, "Start at sequence no.")
	flag.Uint64Var(&endSeq, "last", 0, "End at sequence no.")
	flag.StringVar(&userCreds, "cr", "", "Credentials File")
	flag.StringVar(&userCreds, "creds", "", "Credentials File")

	flag.Usage = usage
	flag.Parse()

	args := flag.Args()

	// Configure Logger.
	log.SetFormatter(&log.TextFormatter{
		FullTimestamp: true,
	})
	log.SetOutput(os.Stderr)

	if quiet {
		log.SetLevel(log.ErrorLevel)
	} else {
		log.SetLevel(log.InfoLevel)
	}

	if len(args) < 1 {
		log.Error("Error: A subject must be specified.")
		usage()
	}

	subject = args[0]
}

func handle_signal() {
	// Wait for a SIGINT (perhaps triggered by user with CTRL-C)
	// Run cleanup when signal is received
	signalChan := make(chan os.Signal, 1)
	signal.Notify(signalChan, os.Interrupt)
	go func() {
		for range signalChan {
			log.Warn("Received an interrupt...")
			_ = finish()
		}
	}()
}

func connect() {
	// Connect Options.
	opts := []nats.Option{
		nats.Name("NATS Streaming Trino Subscriber"),
		nats.RetryOnFailedConnect(true),
		nats.MaxReconnects(-1),
		nats.ReconnectJitter(500 * time.Millisecond, 500 * time.Millisecond),
		nats.ReconnectWait(3 * time.Second),
	}
	// Use UserCredentials
	if userCreds != "" {
		opts = append(opts, nats.UserCredentials(userCreds))
	}

	// Connect to NATS
	var err error
	nc, err = nats.Connect(URL, opts...)
	if err != nil {
		log.Fatal(err)
	}

	// Send PINGs every 30 seconds, and fail after 10 PINGs without any response.
	sc, err = stan.Connect(clusterID, clientID, stan.NatsConn(nc),
		stan.Pings(30, 10),
		stan.SetConnectionLostHandler(func(_ stan.Conn, reason error) {
			log.WithFields(log.Fields{
				"reason": reason,
			}).Fatal("Connection lost...")
		}))
	if err != nil {
		log.WithFields(log.Fields{
			"error": err,
			"url": URL,
		}).Fatal("Could not connect to NATS...")
	}

	log.WithFields(log.Fields{
		"cluster_id": clusterID,
		"client_id": clientID,
		"url": URL,
	}).Info("Connected to NATS...")

	sub, err = sc.Subscribe(subject, callback, stan.StartAtSequence(startSeq))
	if err != nil {
		sc.Close()
		log.Fatal(err)
	}

	log.WithFields(log.Fields{
		"subject": subject,
		"client_id": clientID,
		"start": startSeq,
		"end": endSeq,
	}).Info("Subscribed to subject...")
}

func idle_timer() {
	// If no messages are received for a configurable `idle_timeout` duration,
	// end processing.
	go func() {
		for {
			dur := time.Since(last_time)
			if dur > idle_timeout {
				log.WithFields(log.Fields{
					"seconds": dur,
				}).Info("No recent messages...")
				_ = finish()
				break
			}
			time.Sleep(500 * time.Millisecond)
		}
	}()
}

func main() {
	configure()
	initialize()
	handle_signal()
	connect()
	// idle_timer()

	<-done

	log.Info("Unsubscribing and closing connection...")
	sub.Unsubscribe()
	sc.Close()
}

func callback(msg *stan.Msg) {
	// Ensure that only appropriate messages are handled.
	if msg.Sequence > endSeq {
		if finish() {
			log.Info("All messages received...")
		}
		return
	}

	// Only process the message if we haven't seen it before for exactly once
	// semantics.
	seqNum := uint(msg.Sequence - startSeq)
	seen_mutex.Lock()
	if seen.Test(seqNum) {
		seen_mutex.Unlock()
		return
	}
	seen.Set(seqNum)
	seen_mutex.Unlock()

	data := struct {
		Sequence  uint64 `json:"sequence,omitempty"`
		Subject   string `json:"subject,omitempty"`
		Data      string `json:"data,omitempty"`
		Timestamp int64  `json:"timestamp,omitempty"`
	}{
		msg.Sequence,
		msg.Subject,
		string(msg.Data),
		msg.Timestamp,
	}

	enc := json.NewEncoder(os.Stdout)
	_ = enc.Encode(data)
	last_time = time.Now()

	// No message is guaranteed to come after the last message.
	// Stop if the final message was handled.
	if msg.Sequence >= endSeq {
		if finish() {
			log.Info("All messages received...")
		}
		return
	}
}
