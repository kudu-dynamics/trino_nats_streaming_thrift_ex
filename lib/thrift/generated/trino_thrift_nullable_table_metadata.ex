defmodule(Thrift.Generated.TrinoThriftNullableTableMetadata) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftNullableTableMetadata"
  _ = "1: TrinoThriftService.TrinoThriftTableMetadata table_metadata"
  defstruct(table_metadata: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftNullableTableMetadata{})
    end

    defp(
      deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftNullableTableMetadata{} = acc)
    ) do
      {acc, rest}
    end

    defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftTableMetadata.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | table_metadata: value})

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

    def(
      serialize(%Thrift.Generated.TrinoThriftNullableTableMetadata{table_metadata: table_metadata})
    ) do
      [
        case(table_metadata) do
          nil ->
            <<>>

          _ ->
            [
              <<12, 1::16-signed>>
              | Thrift.Generated.TrinoThriftTableMetadata.serialize(table_metadata)
            ]
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
