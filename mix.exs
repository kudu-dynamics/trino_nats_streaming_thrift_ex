defmodule TrinoNatsStreamingThrift.MixProject do
  use Mix.Project

  def project do
    [
      app: :trino_nats_streaming_thrift,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Thrift configuration
      compilers: [:thrift | Mix.compilers()],
      thrift: [
        files: Mix.Utils.extract_files(["thrift"], [:thrift])
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TrinoNatsStreamingThrift.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:elixir_uuid, "~> 1.2"},
      {:hackney, "~> 1.16.0"},
      {:memoize, "~> 1.3"},
      {:retry, "~> 0.14"},
      {:tesla, "~> 1.4.0"},
      {:thrift, github: "pinterest/elixir-thrift"},
      {:vapor, "~> 0.10.0"}
    ]
  end
end
