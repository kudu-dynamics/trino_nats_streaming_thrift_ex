defmodule TrinoNatsStreamingThrift.Application do
  @moduledoc """
  Documentation for `TrinoNatsStreamingThrift.Application`.
  """
  use Application
  alias Thrift.Generated.TrinoThriftService.Binary.Framed.Server
  alias TrinoNatsStreamingThrift.Config

  def start(_type, _args) do
    Config.configure()

    children = [
      server_child_spec(Config.port())
    ]

    opts = [strategy: :one_for_one, name: TrinoNatsStreamingThrift.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp server_child_spec(port) do
    %{
      id: Server,
      start: {Server, :start_link, [TrinoNatsStreamingThrift.Handler, port]},
      type: :supervisor
    }
  end
end
