defmodule(Thrift.Generated.TrinoThriftTableMetadata) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftTableMetadata"
  _ = "1: TrinoThriftService.TrinoThriftSchemaTableName schema_table_name"
  _ = "2: list<TrinoThriftService.TrinoThriftColumnMetadata> columns"
  _ = "3: string comment"
  _ = "4: list<set<string>> indexable_keys"
  defstruct(schema_table_name: nil, columns: nil, comment: nil, indexable_keys: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftTableMetadata{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftTableMetadata{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftSchemaTableName.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | schema_table_name: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<15, 2::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__columns(rest, [[], remaining, struct])
    end

    defp(
      deserialize(
        <<11, 3::16-signed, string_size::32-signed, value::binary-size(string_size),
          rest::binary>>,
        acc
      )
    ) do
      deserialize(rest, %{acc | comment: value})
    end

    defp(deserialize(<<15, 4::16-signed, 14, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__indexable_keys(rest, [[], remaining, struct])
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    defp(deserialize__columns(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | columns: Enum.reverse(list)})
    end

    defp(deserialize__columns(<<rest::binary>>, [list, remaining | stack])) do
      case(Thrift.Generated.TrinoThriftColumnMetadata.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__columns(rest, [[element | list], remaining - 1 | stack])

        :error ->
          :error
      end
    end

    defp(deserialize__columns(_, _)) do
      :error
    end

    defp(deserialize__indexable_keys(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | indexable_keys: Enum.reverse(list)})
    end

    defp(
      deserialize__indexable_keys(<<11, inner_remaining::32-signed, rest::binary>>, [
        list,
        remaining | stack
      ])
    ) do
      deserialize__indexable_keys__element(rest, [[], inner_remaining, list, remaining | stack])
    end

    defp(deserialize__indexable_keys(_, _)) do
      :error
    end

    defp(
      deserialize__indexable_keys__element(<<rest::binary>>, [
        inner_list,
        0,
        list,
        remaining | stack
      ])
    ) do
      deserialize__indexable_keys(rest, [[MapSet.new(inner_list) | list], remaining - 1 | stack])
    end

    defp(
      deserialize__indexable_keys__element(
        <<string_size::32-signed, element::binary-size(string_size), rest::binary>>,
        [list, remaining | stack]
      )
    ) do
      deserialize__indexable_keys__element(rest, [[element | list], remaining - 1 | stack])
    end

    defp(deserialize__indexable_keys__element(_, _)) do
      :error
    end

    def(
      serialize(%Thrift.Generated.TrinoThriftTableMetadata{
        schema_table_name: schema_table_name,
        columns: columns,
        comment: comment,
        indexable_keys: indexable_keys
      })
    ) do
      [
        case(schema_table_name) do
          nil ->
            <<>>

          _ ->
            [
              <<12, 1::16-signed>>
              | Thrift.Generated.TrinoThriftSchemaTableName.serialize(schema_table_name)
            ]
        end,
        case(columns) do
          nil ->
            <<>>

          _ ->
            [
              <<15, 2::16-signed, 12, length(columns)::32-signed>>
              | for(e <- columns) do
                  Thrift.Generated.TrinoThriftColumnMetadata.serialize(e)
                end
            ]
        end,
        case(comment) do
          nil ->
            <<>>

          _ ->
            [<<11, 3::16-signed, byte_size(comment)::32-signed>> | comment]
        end,
        case(indexable_keys) do
          nil ->
            <<>>

          _ ->
            [
              <<15, 4::16-signed, 14, length(indexable_keys)::32-signed>>
              | for(e <- indexable_keys) do
                  [
                    <<11, Enum.count(e)::32-signed>>
                    | for(e <- e) do
                        [<<byte_size(e)::32-signed>> | e]
                      end
                  ]
                end
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
