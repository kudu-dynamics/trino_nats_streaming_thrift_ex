defmodule TrinoNatsStreamingThrift.NatsStreaming do
  @moduledoc """
  Documentation for `TrinoNatsStreamingThrift.NatsStreaming`.

  Provides an interface for interacting with NATS Streaming. Both over NATS and
  the monitoring HTTP API.
  """
  alias TrinoNatsStreamingThrift.Config
  require Logger
  use Memoize
  use Retry

  @adapter Tesla.Adapter.Hackney
  @expiry_ms 5 * 60 * 1000

  # In the case that the HTTP service is behind a service-aware load balancer.
  defp should_retry({:ok, %{status: status}}) when status in [404], do: true
  defp should_retry({:ok, _}), do: false
  defp should_retry({:error, _}), do: true

  defp middleware,
    do: [
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Retry, [delay: 500, max_retries: 20, should_retry: &should_retry/1]}
    ]

  @doc """
  Subscribe and receive a sequence-windowed list of messages from a NATS
  Streaming channel.
  """

  @spec sub(map()) :: [map()]

  def sub(%{"cluster_id" => cluster_id, "channel" => channel, "lower" => lower, "upper" => upper}) do
    path = System.find_executable("stan-sub")

    args = [
      path,
      "-s",
      Config.nats_url(),
      "-c",
      cluster_id,
      "-id",
      "trino-#{UUID.uuid4()}",
      "--first",
      Integer.to_string(lower),
      "--last",
      Integer.to_string(upper),
      "--quiet",
      channel
    ]

    opts = [:binary, :eof, :exit_status] ++ [args: args]

    # Retry with exponential backoff with 10% jitter capped at 1 minute
    # between attempts.
    retry_while with: exponential_backoff() |> randomize() |> cap(60_000) do
      port = Port.open({:spawn_executable, "./wrapper.sh"}, opts)
      case execute_loop(port, {"", []}) do
        {0, lines} -> {:halt, lines}

        # XXX: Not all errors are the same. Should not continue when
        #      misconfigured.
        _ -> {:cont, nil}

      end
    end
    |> Enum.map(&Jason.decode/1)
    |> Enum.flat_map(fn
      {:ok, result} -> [result]
      _ -> []
    end)
  end

  defp execute_loop(port, {buffer, lines}) do
    receive do
      {^port, {:data, data}} ->
        # Buffer lines as they are read in.
        (buffer <> data)
        |> String.split("\n")
        |> List.pop_at(-1)
        |> case do
          {nil, new_lines} ->
            execute_loop(port, {"", lines ++ new_lines})

          {rest, new_lines} ->
            execute_loop(port, {rest, lines ++ new_lines})
        end

      {^port, :eof} ->
        send(port, {self(), :close})

        receive do
          # Assume anything left in the buffer is a line.
          {^port, {:exit_status, status}} ->
            {
              status,
              (lines ++ [buffer])
              |> Enum.reject(fn line -> line == "" end)
            }
        end
    end
  end

  @doc """
  Get the cluster_id from the Monitoring `serverz` page.

  https://docs.nats.io/nats-streaming-concepts/monitoring/endpoints
  """

  @spec cluster_id(String.t()) :: {:ok, String.t(), String.t()} | {:error, atom()}

  defmemo cluster_id(url), expires_in: @expiry_ms do
    Tesla.client(middleware(), @adapter)
    |> Tesla.get("#{url}/streaming/serverz")
    |> case do
      {:ok, %{status: 200, body: %{"cluster_id" => cluster_id}}} ->
        {:ok, url, cluster_id}

      {_, response} ->
        Logger.error("unexpected response #{Kernel.inspect(response)}")
        {:error, :unexpected_response}
    end
  end

  @doc """
  Get information about a specific channel from the Monitoring `channelsz` page.

  https://docs.nats.io/nats-streaming-concepts/monitoring/endpoints
  """

  @spec channel(String.t(), String.t()) :: {:ok, String.t(), map()} | {:error, atom()}

  defmemo channel(url, channel), expires_in: @expiry_ms do
    Tesla.client(middleware(), @adapter)
    |> Tesla.get("#{url}/streaming/channelsz", query: [channel: channel, subs: "1"])
    |> case do
      {:ok, %{status: 200, body: body}} ->
        {:ok, url, body}

      {_, response} ->
        Logger.error("unexpected response #{Kernel.inspect(response)}")
        {:error, :unexpected_response}
    end
  end

  @doc """
  Get the channels from the Monitoring `channelsz` page.

  https://docs.nats.io/nats-streaming-concepts/monitoring/endpoints
  """

  @spec channels(String.t()) :: {:ok, String.t(), [String.t()]} | {:error, atom()}

  defmemo channels(url), expires_in: @expiry_ms do
    Tesla.client(middleware(), @adapter)
    |> Tesla.get("#{url}/streaming/channelsz", query: [subs: "1"])
    |> case do
      {:ok, %{status: 200, body: %{"channels" => channels}}} ->
        {:ok, url, channels |> Enum.map(fn v -> v["name"] end)}

      {_, response} ->
        Logger.error("unexpected response #{Kernel.inspect(response)}")
        {:error, :unexpected_response}
    end
  end
end
