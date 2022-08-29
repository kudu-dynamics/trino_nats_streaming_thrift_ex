defmodule(Thrift.Generated.TrinoThriftRange) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftRange"
  _ = "1: TrinoThriftService.TrinoThriftMarker low"
  _ = "2: TrinoThriftService.TrinoThriftMarker high"
  defstruct(low: nil, high: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftRange{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftRange{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftMarker.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | low: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 2::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftMarker.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | high: value})

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

    def(serialize(%Thrift.Generated.TrinoThriftRange{low: low, high: high})) do
      [
        case(low) do
          nil ->
            <<>>

          _ ->
            [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftMarker.serialize(low)]
        end,
        case(high) do
          nil ->
            <<>>

          _ ->
            [<<12, 2::16-signed>> | Thrift.Generated.TrinoThriftMarker.serialize(high)]
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
