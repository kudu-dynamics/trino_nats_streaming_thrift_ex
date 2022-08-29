defmodule(Thrift.Generated.TrinoThriftMarker) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftMarker"
  _ = "1: TrinoThriftService.TrinoThriftBlock value"
  _ = "2: TrinoThriftService.TrinoThriftBound bound"
  defstruct(value: nil, bound: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftMarker{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftMarker{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftBlock.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | value: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<8, 2::16-signed, value::32-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | bound: value})
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    def(serialize(%Thrift.Generated.TrinoThriftMarker{value: value, bound: bound})) do
      [
        case(value) do
          nil ->
            <<>>

          _ ->
            [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftBlock.serialize(value)]
        end,
        case(bound) do
          nil ->
            <<>>

          _ ->
            <<8, 2::16-signed, bound::32-signed>>
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
