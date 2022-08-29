defmodule(Thrift.Generated.TrinoThriftSchemaTableName) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftSchemaTableName"
  _ = "1: string schema_name"
  _ = "2: string table_name"
  defstruct(schema_name: nil, table_name: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftSchemaTableName{})
    end

    defp(
      deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftSchemaTableName{} = acc)
    ) do
      {acc, rest}
    end

    defp(
      deserialize(
        <<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size),
          rest::binary>>,
        acc
      )
    ) do
      deserialize(rest, %{acc | schema_name: value})
    end

    defp(
      deserialize(
        <<11, 2::16-signed, string_size::32-signed, value::binary-size(string_size),
          rest::binary>>,
        acc
      )
    ) do
      deserialize(rest, %{acc | table_name: value})
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    def(
      serialize(%Thrift.Generated.TrinoThriftSchemaTableName{
        schema_name: schema_name,
        table_name: table_name
      })
    ) do
      [
        case(schema_name) do
          nil ->
            <<>>

          _ ->
            [<<11, 1::16-signed, byte_size(schema_name)::32-signed>> | schema_name]
        end,
        case(table_name) do
          nil ->
            <<>>

          _ ->
            [<<11, 2::16-signed, byte_size(table_name)::32-signed>> | table_name]
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
