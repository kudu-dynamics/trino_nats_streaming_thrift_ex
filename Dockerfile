# --------------------------------------------------------------------------- #

FROM golang:1.16.0-alpine AS go-build

COPY utils/stan-sub /src/stan-sub

ENV CGO_ENABLED=0

WORKDIR /src/stan-sub

RUN go mod tidy                                \
 && go build -ldflags "-s -w" -o /out/stan-sub

# --------------------------------------------------------------------------- #

FROM elixir:1.11.3-slim AS build

COPY config /app/config
COPY lib /app/lib
COPY mix.exs /app/
COPY mix.lock /app/

ENV MIX_ENV=prod

WORKDIR /app/

RUN apt update                                                 \
 && apt install --no-install-recommends -y ca-certificates git \
 && mix local.hex --force                                      \
 && mix local.rebar --force                                    \
 && mix deps.get                                               \
 && mix release

# --------------------------------------------------------------------------- #

# DEV: Use slim instead of alpine as the Port wrapper is written in Bash.
FROM elixir:1.11.3-slim AS RELEASE

RUN                         \
  useradd --create-home app

WORKDIR /home/app

COPY --from=go-build /out/stan-sub /usr/local/bin/
COPY --from=build /app/_build/prod/rel/* .
COPY entrypoint.sh ./
COPY wrapper.sh ./

RUN chown -R app: ./       \
 && chmod +x entrypoint.sh \
 && chmod +x wrapper.sh

USER app

ENV MIX_ENV=prod

ENTRYPOINT ["./entrypoint.sh"]

# --------------------------------------------------------------------------- #
