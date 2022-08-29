import Config

config :logger, :console,
  device: :standard_error,
  format: "$time $metadata[$level] $levelpad$message\n"
