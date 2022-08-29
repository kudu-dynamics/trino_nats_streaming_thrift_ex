defmodule(Thrift.Generated.TrinoThriftHostAddress) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftHostAddress"
  _ = "1: string host"
  _ = "2: i32 port"
  defstruct(host: nil, port: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftHostAddress{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftHostAddress{} = acc)) do
      {acc, rest}
    end

    defp(
      deserialize(
        <<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size),
          rest::binary>>,
        acc
      )
    ) do
      deserialize(rest, %{acc | host: value})
    end

    defp(deserialize(<<8, 2::16-signed, value::32-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | port: value})
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    def(serialize(%Thrift.Generated.TrinoThriftHostAddress{host: host, port: port})) do
      [
        case(host) do
          nil ->
            <<>>

          _ ->
            [<<11, 1::16-signed, byte_size(host)::32-signed>> | host]
        end,
        case(port) do
          nil ->
            <<>>

          _ ->
            <<8, 2::16-signed, port::32-signed>>
        end
        | <<0>>
      ]
    end
  end

  def(serialize(struct)) do
    BinaryProtocol.serialize(struct)
  end

  def(serialize(struct, :binary)) do
    BinaryProtocol.serialize(struct)
  end

  def(deserialize(binary)) do
    BinaryProtocol.deserialize(binary)
  end
end
