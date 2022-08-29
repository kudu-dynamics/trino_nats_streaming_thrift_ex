defmodule TrinoNatsStreamingThrift.Config do
  @moduledoc """
  Documentation for `TrinoNatsStreamingThrift.Config`.

  Provides a convenience for configuring the application.
  """
  alias Vapor.Provider.{Env, File}
  require Logger

  @app Keyword.get(Mix.Project.config(), :app)

  @doc """
  Load dynamic runtime configuration settings.
  """

  def configure do
    Logger.configure(level: :info, utc_log: true)

    [
      %File{
        path: "config.toml",
        bindings: [
          {:nats_url, "nats_url", required: false},
          {:split_size, "split_size", map: &String.to_integer/1, required: false},
          {:stan_urls, "stan_urls", required: false}
        ]
      },
      %Env{
        bindings: [
          {:nats_url, "NATS_URL", required: false},
          {:port, "PORT", map: &String.to_integer/1, required: false},
          {:split_size, "SPLIT_SIZE", map: &String.to_integer/1, required: false},
          {:stan_urls, "STAN_URLS", map: &String.split(&1, ","), required: false}
        ]
      }
    ]
    |> loadall()
    |> setdefaults()
    |> writetoenv()
  end

  # Call the below functions after configure has been called once.

  def nats_process, do: :gnat
  def nats_url, do: Application.get_env(@app, :nats_url)
  def port, do: Application.get_env(@app, :port)
  def split_size, do: Application.get_env(@app, :split_size)
  def stan_urls, do: Application.get_env(@app, :stan_urls)

  # Private functions.

  defp loadfn(provider, acc) do
    provider
    |> Vapor.load()
    |> case do
      {:ok, config} -> Map.merge(acc, config, &mergefn/3)
      {:error, _errors} -> acc
    end
  end

  defp loadall(providers) do
    providers
    |> Enum.reduce(%{}, &loadfn/2)
  end

  defp mergefn(_, nil, v), do: v
  defp mergefn(_, v, nil), do: v
  defp mergefn(_, _, v), do: v

  defp setdefaults(config) do
    %{
      nats_url: "nats://localhost:4222",
      port: 9090,
      split_size: 50_000,
      stan_urls: ["http://localhost:8222"]
    }
    |> Map.merge(config, &mergefn/3)
  end

  defp writetoenv(config) do
    config
    |> Enum.map(fn {k, v} -> Application.put_env(@app, k, v) end)
  end
end
