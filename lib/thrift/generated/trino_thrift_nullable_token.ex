defmodule(Thrift.Generated.TrinoThriftNullableToken) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftNullableToken"
  _ = "1: TrinoThriftService.TrinoThriftId token"
  defstruct(token: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftNullableToken{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftNullableToken{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftId.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | token: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    def(serialize(%Thrift.Generated.TrinoThriftNullableToken{token: token})) do
      [
        case(token) do
          nil ->
            <<>>

          _ ->
            [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftId.serialize(token)]
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
