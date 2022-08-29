defmodule(Thrift.Generated.TrinoThriftService) do
  @moduledoc false
  defmodule(TrinoGetIndexSplitsArgs) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoGetIndexSplitsArgs"
    _ = "1: TrinoThriftService.TrinoThriftSchemaTableName schema_table_name"
    _ = "2: list<string> index_column_names"
    _ = "3: list<string> output_column_names"
    _ = "4: TrinoThriftService.TrinoThriftPageResult keys"
    _ = "5: TrinoThriftService.TrinoThriftTupleDomain output_constraint"
    _ = "6: i32 max_split_count"
    _ = "7: TrinoThriftService.TrinoThriftNullableToken next_token"

    defstruct(
      schema_table_name: nil,
      index_column_names: nil,
      output_column_names: nil,
      keys: nil,
      output_constraint: nil,
      max_split_count: nil,
      next_token: nil
    )

    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoGetIndexSplitsArgs{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoGetIndexSplitsArgs{} = acc)) do
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

      defp(deserialize(<<15, 2::16-signed, 11, remaining::32-signed, rest::binary>>, struct)) do
        deserialize__index_column_names(rest, [[], remaining, struct])
      end

      defp(deserialize(<<15, 3::16-signed, 11, remaining::32-signed, rest::binary>>, struct)) do
        deserialize__output_column_names(rest, [[], remaining, struct])
      end

      defp(deserialize(<<12, 4::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftPageResult.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | keys: value})

          :error ->
            :error
        end
      end

      defp(deserialize(<<12, 5::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftTupleDomain.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | output_constraint: value})

          :error ->
            :error
        end
      end

      defp(deserialize(<<8, 6::16-signed, value::32-signed, rest::binary>>, acc)) do
        deserialize(rest, %{acc | max_split_count: value})
      end

      defp(deserialize(<<12, 7::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftNullableToken.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | next_token: value})

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

      defp(deserialize__index_column_names(<<rest::binary>>, [list, 0, struct])) do
        deserialize(rest, %{struct | index_column_names: Enum.reverse(list)})
      end

      defp(
        deserialize__index_column_names(
          <<string_size::32-signed, element::binary-size(string_size), rest::binary>>,
          [list, remaining | stack]
        )
      ) do
        deserialize__index_column_names(rest, [[element | list], remaining - 1 | stack])
      end

      defp(deserialize__index_column_names(_, _)) do
        :error
      end

      defp(deserialize__output_column_names(<<rest::binary>>, [list, 0, struct])) do
        deserialize(rest, %{struct | output_column_names: Enum.reverse(list)})
      end

      defp(
        deserialize__output_column_names(
          <<string_size::32-signed, element::binary-size(string_size), rest::binary>>,
          [list, remaining | stack]
        )
      ) do
        deserialize__output_column_names(rest, [[element | list], remaining - 1 | stack])
      end

      defp(deserialize__output_column_names(_, _)) do
        :error
      end

      def(
        serialize(%TrinoGetIndexSplitsArgs{
          schema_table_name: schema_table_name,
          index_column_names: index_column_names,
          output_column_names: output_column_names,
          keys: keys,
          output_constraint: output_constraint,
          max_split_count: max_split_count,
          next_token: next_token
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
          case(index_column_names) do
            nil ->
              <<>>

            _ ->
              [
                <<15, 2::16-signed, 11, length(index_column_names)::32-signed>>
                | for(e <- index_column_names) do
                    [<<byte_size(e)::32-signed>> | e]
                  end
              ]
          end,
          case(output_column_names) do
            nil ->
              <<>>

            _ ->
              [
                <<15, 3::16-signed, 11, length(output_column_names)::32-signed>>
                | for(e <- output_column_names) do
                    [<<byte_size(e)::32-signed>> | e]
                  end
              ]
          end,
          case(keys) do
            nil ->
              <<>>

            _ ->
              [<<12, 4::16-signed>> | Thrift.Generated.TrinoThriftPageResult.serialize(keys)]
          end,
          case(output_constraint) do
            nil ->
              <<>>

            _ ->
              [
                <<12, 5::16-signed>>
                | Thrift.Generated.TrinoThriftTupleDomain.serialize(output_constraint)
              ]
          end,
          case(max_split_count) do
            nil ->
              <<>>

            _ ->
              <<8, 6::16-signed, max_split_count::32-signed>>
          end,
          case(next_token) do
            nil ->
              <<>>

            _ ->
              [
                <<12, 7::16-signed>>
                | Thrift.Generated.TrinoThriftNullableToken.serialize(next_token)
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

  defmodule(TrinoGetRowsArgs) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoGetRowsArgs"
    _ = "1: TrinoThriftService.TrinoThriftId split_id"
    _ = "2: list<string> columns"
    _ = "3: i64 max_bytes"
    _ = "4: TrinoThriftService.TrinoThriftNullableToken next_token"
    defstruct(split_id: nil, columns: nil, max_bytes: nil, next_token: nil)
    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoGetRowsArgs{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoGetRowsArgs{} = acc)) do
        {acc, rest}
      end

      defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftId.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | split_id: value})

          :error ->
            :error
        end
      end

      defp(deserialize(<<15, 2::16-signed, 11, remaining::32-signed, rest::binary>>, struct)) do
        deserialize__columns(rest, [[], remaining, struct])
      end

      defp(deserialize(<<10, 3::16-signed, value::64-signed, rest::binary>>, acc)) do
        deserialize(rest, %{acc | max_bytes: value})
      end

      defp(deserialize(<<12, 4::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftNullableToken.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | next_token: value})

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

      defp(deserialize__columns(<<rest::binary>>, [list, 0, struct])) do
        deserialize(rest, %{struct | columns: Enum.reverse(list)})
      end

      defp(
        deserialize__columns(
          <<string_size::32-signed, element::binary-size(string_size), rest::binary>>,
          [list, remaining | stack]
        )
      ) do
        deserialize__columns(rest, [[element | list], remaining - 1 | stack])
      end

      defp(deserialize__columns(_, _)) do
        :error
      end

      def(
        serialize(%TrinoGetRowsArgs{
          split_id: split_id,
          columns: columns,
          max_bytes: max_bytes,
          next_token: next_token
        })
      ) do
        [
          case(split_id) do
            nil ->
              <<>>

            _ ->
              [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftId.serialize(split_id)]
          end,
          case(columns) do
            nil ->
              <<>>

            _ ->
              [
                <<15, 2::16-signed, 11, length(columns)::32-signed>>
                | for(e <- columns) do
                    [<<byte_size(e)::32-signed>> | e]
                  end
              ]
          end,
          case(max_bytes) do
            nil ->
              <<>>

            _ ->
              <<10, 3::16-signed, max_bytes::64-signed>>
          end,
          case(next_token) do
            nil ->
              <<>>

            _ ->
              [
                <<12, 4::16-signed>>
                | Thrift.Generated.TrinoThriftNullableToken.serialize(next_token)
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

  defmodule(TrinoGetSplitsArgs) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoGetSplitsArgs"
    _ = "1: TrinoThriftService.TrinoThriftSchemaTableName schema_table_name"
    _ = "2: TrinoThriftService.TrinoThriftNullableColumnSet desired_columns"
    _ = "3: TrinoThriftService.TrinoThriftTupleDomain output_constraint"
    _ = "4: i32 max_split_count"
    _ = "5: TrinoThriftService.TrinoThriftNullableToken next_token"

    defstruct(
      schema_table_name: nil,
      desired_columns: nil,
      output_constraint: nil,
      max_split_count: nil,
      next_token: nil
    )

    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoGetSplitsArgs{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoGetSplitsArgs{} = acc)) do
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

      defp(deserialize(<<12, 2::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftNullableColumnSet.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | desired_columns: value})

          :error ->
            :error
        end
      end

      defp(deserialize(<<12, 3::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftTupleDomain.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | output_constraint: value})

          :error ->
            :error
        end
      end

      defp(deserialize(<<8, 4::16-signed, value::32-signed, rest::binary>>, acc)) do
        deserialize(rest, %{acc | max_split_count: value})
      end

      defp(deserialize(<<12, 5::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftNullableToken.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | next_token: value})

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
        serialize(%TrinoGetSplitsArgs{
          schema_table_name: schema_table_name,
          desired_columns: desired_columns,
          output_constraint: output_constraint,
          max_split_count: max_split_count,
          next_token: next_token
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
          case(desired_columns) do
            nil ->
              <<>>

            _ ->
              [
                <<12, 2::16-signed>>
                | Thrift.Generated.TrinoThriftNullableColumnSet.serialize(desired_columns)
              ]
          end,
          case(output_constraint) do
            nil ->
              <<>>

            _ ->
              [
                <<12, 3::16-signed>>
                | Thrift.Generated.TrinoThriftTupleDomain.serialize(output_constraint)
              ]
          end,
          case(max_split_count) do
            nil ->
              <<>>

            _ ->
              <<8, 4::16-signed, max_split_count::32-signed>>
          end,
          case(next_token) do
            nil ->
              <<>>

            _ ->
              [
                <<12, 5::16-signed>>
                | Thrift.Generated.TrinoThriftNullableToken.serialize(next_token)
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

  defmodule(TrinoGetTableMetadataArgs) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoGetTableMetadataArgs"
    _ = "1: TrinoThriftService.TrinoThriftSchemaTableName schema_table_name"
    defstruct(schema_table_name: nil)
    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoGetTableMetadataArgs{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoGetTableMetadataArgs{} = acc)) do
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

      defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
        rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
      end

      defp(deserialize(_, _)) do
        :error
      end

      def(serialize(%TrinoGetTableMetadataArgs{schema_table_name: schema_table_name})) do
        [
          case(schema_table_name) do
            nil ->
              <<>>

            _ ->
              [
                <<12, 1::16-signed>>
                | Thrift.Generated.TrinoThriftSchemaTableName.serialize(schema_table_name)
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

  defmodule(TrinoListSchemaNamesArgs) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoListSchemaNamesArgs"
    defstruct([])
    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoListSchemaNamesArgs{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoListSchemaNamesArgs{} = acc)) do
        {acc, rest}
      end

      defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
        rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
      end

      defp(deserialize(_, _)) do
        :error
      end

      def(serialize(%TrinoListSchemaNamesArgs{})) do
        <<0>>
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

  defmodule(TrinoListTablesArgs) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoListTablesArgs"
    _ = "1: TrinoThriftService.TrinoThriftNullableSchemaName schema_name_or_null"
    defstruct(schema_name_or_null: nil)
    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoListTablesArgs{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoListTablesArgs{} = acc)) do
        {acc, rest}
      end

      defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftNullableSchemaName.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | schema_name_or_null: value})

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

      def(serialize(%TrinoListTablesArgs{schema_name_or_null: schema_name_or_null})) do
        [
          case(schema_name_or_null) do
            nil ->
              <<>>

            _ ->
              [
                <<12, 1::16-signed>>
                | Thrift.Generated.TrinoThriftNullableSchemaName.serialize(schema_name_or_null)
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

  defmodule(TrinoGetIndexSplitsResponse) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoGetIndexSplitsResponse"
    _ = "0: TrinoThriftService.TrinoThriftSplitBatch success"
    _ = "1: TrinoThriftService.TrinoThriftServiceException ex1"
    defstruct(success: nil, ex1: nil)
    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoGetIndexSplitsResponse{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoGetIndexSplitsResponse{} = acc)) do
        {acc, rest}
      end

      defp(deserialize(<<12, 0::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftSplitBatch.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | success: value})

          :error ->
            :error
        end
      end

      defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftServiceException.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | ex1: value})

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

      def(serialize(%TrinoGetIndexSplitsResponse{success: success, ex1: ex1})) do
        [
          case(success) do
            nil ->
              <<>>

            _ ->
              [<<12, 0::16-signed>> | Thrift.Generated.TrinoThriftSplitBatch.serialize(success)]
          end,
          case(ex1) do
            nil ->
              <<>>

            _ ->
              [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftServiceException.serialize(ex1)]
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

  defmodule(TrinoGetRowsResponse) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoGetRowsResponse"
    _ = "0: TrinoThriftService.TrinoThriftPageResult success"
    _ = "1: TrinoThriftService.TrinoThriftServiceException ex1"
    defstruct(success: nil, ex1: nil)
    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoGetRowsResponse{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoGetRowsResponse{} = acc)) do
        {acc, rest}
      end

      defp(deserialize(<<12, 0::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftPageResult.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | success: value})

          :error ->
            :error
        end
      end

      defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftServiceException.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | ex1: value})

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

      def(serialize(%TrinoGetRowsResponse{success: success, ex1: ex1})) do
        [
          case(success) do
            nil ->
              <<>>

            _ ->
              [<<12, 0::16-signed>> | Thrift.Generated.TrinoThriftPageResult.serialize(success)]
          end,
          case(ex1) do
            nil ->
              <<>>

            _ ->
              [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftServiceException.serialize(ex1)]
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

  defmodule(TrinoGetSplitsResponse) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoGetSplitsResponse"
    _ = "0: TrinoThriftService.TrinoThriftSplitBatch success"
    _ = "1: TrinoThriftService.TrinoThriftServiceException ex1"
    defstruct(success: nil, ex1: nil)
    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoGetSplitsResponse{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoGetSplitsResponse{} = acc)) do
        {acc, rest}
      end

      defp(deserialize(<<12, 0::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftSplitBatch.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | success: value})

          :error ->
            :error
        end
      end

      defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftServiceException.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | ex1: value})

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

      def(serialize(%TrinoGetSplitsResponse{success: success, ex1: ex1})) do
        [
          case(success) do
            nil ->
              <<>>

            _ ->
              [<<12, 0::16-signed>> | Thrift.Generated.TrinoThriftSplitBatch.serialize(success)]
          end,
          case(ex1) do
            nil ->
              <<>>

            _ ->
              [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftServiceException.serialize(ex1)]
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

  defmodule(TrinoGetTableMetadataResponse) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoGetTableMetadataResponse"
    _ = "0: TrinoThriftService.TrinoThriftNullableTableMetadata success"
    _ = "1: TrinoThriftService.TrinoThriftServiceException ex1"
    defstruct(success: nil, ex1: nil)
    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoGetTableMetadataResponse{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoGetTableMetadataResponse{} = acc)) do
        {acc, rest}
      end

      defp(deserialize(<<12, 0::16-signed, rest::binary>>, acc)) do
        case(
          Thrift.Generated.TrinoThriftNullableTableMetadata.BinaryProtocol.deserialize(rest)
        ) do
          {value, rest} ->
            deserialize(rest, %{acc | success: value})

          :error ->
            :error
        end
      end

      defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftServiceException.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | ex1: value})

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

      def(serialize(%TrinoGetTableMetadataResponse{success: success, ex1: ex1})) do
        [
          case(success) do
            nil ->
              <<>>

            _ ->
              [
                <<12, 0::16-signed>>
                | Thrift.Generated.TrinoThriftNullableTableMetadata.serialize(success)
              ]
          end,
          case(ex1) do
            nil ->
              <<>>

            _ ->
              [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftServiceException.serialize(ex1)]
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

  defmodule(TrinoListSchemaNamesResponse) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoListSchemaNamesResponse"
    _ = "0: list<string> success"
    _ = "1: TrinoThriftService.TrinoThriftServiceException ex1"
    defstruct(success: nil, ex1: nil)
    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoListSchemaNamesResponse{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoListSchemaNamesResponse{} = acc)) do
        {acc, rest}
      end

      defp(deserialize(<<15, 0::16-signed, 11, remaining::32-signed, rest::binary>>, struct)) do
        deserialize__success(rest, [[], remaining, struct])
      end

      defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftServiceException.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | ex1: value})

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

      defp(deserialize__success(<<rest::binary>>, [list, 0, struct])) do
        deserialize(rest, %{struct | success: Enum.reverse(list)})
      end

      defp(
        deserialize__success(
          <<string_size::32-signed, element::binary-size(string_size), rest::binary>>,
          [list, remaining | stack]
        )
      ) do
        deserialize__success(rest, [[element | list], remaining - 1 | stack])
      end

      defp(deserialize__success(_, _)) do
        :error
      end

      def(serialize(%TrinoListSchemaNamesResponse{success: success, ex1: ex1})) do
        [
          case(success) do
            nil ->
              <<>>

            _ ->
              [
                <<15, 0::16-signed, 11, length(success)::32-signed>>
                | for(e <- success) do
                    [<<byte_size(e)::32-signed>> | e]
                  end
              ]
          end,
          case(ex1) do
            nil ->
              <<>>

            _ ->
              [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftServiceException.serialize(ex1)]
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

  defmodule(TrinoListTablesResponse) do
    @moduledoc false
    _ = "Auto-generated Thrift struct Elixir.TrinoListTablesResponse"
    _ = "0: list<TrinoThriftService.TrinoThriftSchemaTableName> success"
    _ = "1: TrinoThriftService.TrinoThriftServiceException ex1"
    defstruct(success: nil, ex1: nil)
    @type t :: %__MODULE__{}
    def(new) do
      %__MODULE__{}
    end

    defmodule(BinaryProtocol) do
      @moduledoc false
      def(deserialize(binary)) do
        deserialize(binary, %TrinoListTablesResponse{})
      end

      defp(deserialize(<<0, rest::binary>>, %TrinoListTablesResponse{} = acc)) do
        {acc, rest}
      end

      defp(deserialize(<<15, 0::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
        deserialize__success(rest, [[], remaining, struct])
      end

      defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
        case(Thrift.Generated.TrinoThriftServiceException.BinaryProtocol.deserialize(rest)) do
          {value, rest} ->
            deserialize(rest, %{acc | ex1: value})

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

      defp(deserialize__success(<<rest::binary>>, [list, 0, struct])) do
        deserialize(rest, %{struct | success: Enum.reverse(list)})
      end

      defp(deserialize__success(<<rest::binary>>, [list, remaining | stack])) do
        case(Thrift.Generated.TrinoThriftSchemaTableName.BinaryProtocol.deserialize(rest)) do
          {element, rest} ->
            deserialize__success(rest, [[element | list], remaining - 1 | stack])

          :error ->
            :error
        end
      end

      defp(deserialize__success(_, _)) do
        :error
      end

      def(serialize(%TrinoListTablesResponse{success: success, ex1: ex1})) do
        [
          case(success) do
            nil ->
              <<>>

            _ ->
              [
                <<15, 0::16-signed, 12, length(success)::32-signed>>
                | for(e <- success) do
                    Thrift.Generated.TrinoThriftSchemaTableName.serialize(e)
                  end
              ]
          end,
          case(ex1) do
            nil ->
              <<>>

            _ ->
              [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftServiceException.serialize(ex1)]
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

  defmodule(Binary.Framed.Client) do
    @moduledoc false
    alias(Thrift.Binary.Framed.Client, as: ClientImpl)
    defdelegate(close(conn), to: ClientImpl)
    defdelegate(connect(conn, opts), to: ClientImpl)
    defdelegate(start_link(host, port, opts \\ []), to: ClientImpl)

    def(
      unquote(:trino_get_index_splits)(
        client,
        schema_table_name,
        index_column_names,
        output_column_names,
        keys,
        output_constraint,
        max_split_count,
        next_token,
        rpc_opts \\ []
      )
    ) do
      args = %TrinoGetIndexSplitsArgs{
        schema_table_name: schema_table_name,
        index_column_names: index_column_names,
        output_column_names: output_column_names,
        keys: keys,
        output_constraint: output_constraint,
        max_split_count: max_split_count,
        next_token: next_token
      }

      serialized_args = TrinoGetIndexSplitsArgs.BinaryProtocol.serialize(args)

      ClientImpl.call(
        client,
        "trinoGetIndexSplits",
        serialized_args,
        TrinoGetIndexSplitsResponse.BinaryProtocol,
        rpc_opts
      )
    end

    def(
      unquote(:trino_get_index_splits!)(
        client,
        schema_table_name,
        index_column_names,
        output_column_names,
        keys,
        output_constraint,
        max_split_count,
        next_token,
        rpc_opts \\ []
      )
    ) do
      case(
        unquote(:trino_get_index_splits)(
          client,
          schema_table_name,
          index_column_names,
          output_column_names,
          keys,
          output_constraint,
          max_split_count,
          next_token,
          rpc_opts
        )
      ) do
        {:ok, rsp} ->
          rsp

        {:error, {:exception, ex}} ->
          raise(ex)

        {:error, reason} ->
          raise(Thrift.ConnectionError, reason: reason)
      end
    end

    def(
      unquote(:trino_get_rows)(client, split_id, columns, max_bytes, next_token, rpc_opts \\ [])
    ) do
      args = %TrinoGetRowsArgs{
        split_id: split_id,
        columns: columns,
        max_bytes: max_bytes,
        next_token: next_token
      }

      serialized_args = TrinoGetRowsArgs.BinaryProtocol.serialize(args)

      ClientImpl.call(
        client,
        "trinoGetRows",
        serialized_args,
        TrinoGetRowsResponse.BinaryProtocol,
        rpc_opts
      )
    end

    def(
      unquote(:trino_get_rows!)(client, split_id, columns, max_bytes, next_token, rpc_opts \\ [])
    ) do
      case(
        unquote(:trino_get_rows)(client, split_id, columns, max_bytes, next_token, rpc_opts)
      ) do
        {:ok, rsp} ->
          rsp

        {:error, {:exception, ex}} ->
          raise(ex)

        {:error, reason} ->
          raise(Thrift.ConnectionError, reason: reason)
      end
    end

    def(
      unquote(:trino_get_splits)(
        client,
        schema_table_name,
        desired_columns,
        output_constraint,
        max_split_count,
        next_token,
        rpc_opts \\ []
      )
    ) do
      args = %TrinoGetSplitsArgs{
        schema_table_name: schema_table_name,
        desired_columns: desired_columns,
        output_constraint: output_constraint,
        max_split_count: max_split_count,
        next_token: next_token
      }

      serialized_args = TrinoGetSplitsArgs.BinaryProtocol.serialize(args)

      ClientImpl.call(
        client,
        "trinoGetSplits",
        serialized_args,
        TrinoGetSplitsResponse.BinaryProtocol,
        rpc_opts
      )
    end

    def(
      unquote(:trino_get_splits!)(
        client,
        schema_table_name,
        desired_columns,
        output_constraint,
        max_split_count,
        next_token,
        rpc_opts \\ []
      )
    ) do
      case(
        unquote(:trino_get_splits)(
          client,
          schema_table_name,
          desired_columns,
          output_constraint,
          max_split_count,
          next_token,
          rpc_opts
        )
      ) do
        {:ok, rsp} ->
          rsp

        {:error, {:exception, ex}} ->
          raise(ex)

        {:error, reason} ->
          raise(Thrift.ConnectionError, reason: reason)
      end
    end

    def(unquote(:trino_get_table_metadata)(client, schema_table_name, rpc_opts \\ [])) do
      args = %TrinoGetTableMetadataArgs{schema_table_name: schema_table_name}
      serialized_args = TrinoGetTableMetadataArgs.BinaryProtocol.serialize(args)

      ClientImpl.call(
        client,
        "trinoGetTableMetadata",
        serialized_args,
        TrinoGetTableMetadataResponse.BinaryProtocol,
        rpc_opts
      )
    end

    def(unquote(:trino_get_table_metadata!)(client, schema_table_name, rpc_opts \\ [])) do
      case(unquote(:trino_get_table_metadata)(client, schema_table_name, rpc_opts)) do
        {:ok, rsp} ->
          rsp

        {:error, {:exception, ex}} ->
          raise(ex)

        {:error, reason} ->
          raise(Thrift.ConnectionError, reason: reason)
      end
    end

    def(unquote(:trino_list_schema_names)(client, rpc_opts \\ [])) do
      args = %TrinoListSchemaNamesArgs{}
      serialized_args = TrinoListSchemaNamesArgs.BinaryProtocol.serialize(args)

      ClientImpl.call(
        client,
        "trinoListSchemaNames",
        serialized_args,
        TrinoListSchemaNamesResponse.BinaryProtocol,
        rpc_opts
      )
    end

    def(unquote(:trino_list_schema_names!)(client, rpc_opts \\ [])) do
      case(unquote(:trino_list_schema_names)(client, rpc_opts)) do
        {:ok, rsp} ->
          rsp

        {:error, {:exception, ex}} ->
          raise(ex)

        {:error, reason} ->
          raise(Thrift.ConnectionError, reason: reason)
      end
    end

    def(unquote(:trino_list_tables)(client, schema_name_or_null, rpc_opts \\ [])) do
      args = %TrinoListTablesArgs{schema_name_or_null: schema_name_or_null}
      serialized_args = TrinoListTablesArgs.BinaryProtocol.serialize(args)

      ClientImpl.call(
        client,
        "trinoListTables",
        serialized_args,
        TrinoListTablesResponse.BinaryProtocol,
        rpc_opts
      )
    end

    def(unquote(:trino_list_tables!)(client, schema_name_or_null, rpc_opts \\ [])) do
      case(unquote(:trino_list_tables)(client, schema_name_or_null, rpc_opts)) do
        {:ok, rsp} ->
          rsp

        {:error, {:exception, ex}} ->
          raise(ex)

        {:error, reason} ->
          raise(Thrift.ConnectionError, reason: reason)
      end
    end
  end

  defmodule(Binary.Framed.Server) do
    @moduledoc false
    require(Logger)
    alias(Thrift.Binary.Framed.Server, as: ServerImpl)
    defdelegate(stop(name), to: ServerImpl)

    def(start_link(handler_module, port, opts \\ [])) do
      ServerImpl.start_link(__MODULE__, port, handler_module, opts)
    end

    def(handle_thrift("trinoGetIndexSplits", binary_data, handler_module)) do
      case(
        Thrift.Generated.TrinoThriftService.TrinoGetIndexSplitsArgs.BinaryProtocol.deserialize(
          binary_data
        )
      ) do
        {%Thrift.Generated.TrinoThriftService.TrinoGetIndexSplitsArgs{
           schema_table_name: schema_table_name,
           index_column_names: index_column_names,
           output_column_names: output_column_names,
           keys: keys,
           output_constraint: output_constraint,
           max_split_count: max_split_count,
           next_token: next_token
         }, ""} ->
          try do
            result =
              handler_module.trino_get_index_splits(
                schema_table_name,
                index_column_names,
                output_column_names,
                keys,
                output_constraint,
                max_split_count,
                next_token
              )

            response = %Thrift.Generated.TrinoThriftService.TrinoGetIndexSplitsResponse{
              success: result
            }

            {:reply,
             Thrift.Generated.TrinoThriftService.TrinoGetIndexSplitsResponse.BinaryProtocol.serialize(
               response
             )}
          catch
            :error, %Thrift.Generated.TrinoThriftServiceException{} = ex1 ->
              response = %Thrift.Generated.TrinoThriftService.TrinoGetIndexSplitsResponse{
                ex1: ex1
              }

              {:reply,
               Thrift.Generated.TrinoThriftService.TrinoGetIndexSplitsResponse.BinaryProtocol.serialize(
                 response
               )}

            kind, reason ->
              formatted_exception = Exception.format(kind, reason, System.stacktrace())

              Logger.error(
                "Exception not defined in thrift spec was thrown: #{formatted_exception}"
              )

              error =
                Thrift.TApplicationException.exception(
                  type: :internal_error,
                  message: "Server error: #{formatted_exception}"
                )

              {:server_error, error}
          end

        {_, extra} ->
          raise(Thrift.TApplicationException,
            type: :protocol_error,
            message: "Could not decode #{inspect(extra)}"
          )
      end
    end

    def(handle_thrift("trinoGetRows", binary_data, handler_module)) do
      case(
        Thrift.Generated.TrinoThriftService.TrinoGetRowsArgs.BinaryProtocol.deserialize(
          binary_data
        )
      ) do
        {%Thrift.Generated.TrinoThriftService.TrinoGetRowsArgs{
           split_id: split_id,
           columns: columns,
           max_bytes: max_bytes,
           next_token: next_token
         }, ""} ->
          try do
            result = handler_module.trino_get_rows(split_id, columns, max_bytes, next_token)
            response = %Thrift.Generated.TrinoThriftService.TrinoGetRowsResponse{success: result}

            {:reply,
             Thrift.Generated.TrinoThriftService.TrinoGetRowsResponse.BinaryProtocol.serialize(
               response
             )}
          catch
            :error, %Thrift.Generated.TrinoThriftServiceException{} = ex1 ->
              response = %Thrift.Generated.TrinoThriftService.TrinoGetRowsResponse{ex1: ex1}

              {:reply,
               Thrift.Generated.TrinoThriftService.TrinoGetRowsResponse.BinaryProtocol.serialize(
                 response
               )}

            kind, reason ->
              formatted_exception = Exception.format(kind, reason, System.stacktrace())

              Logger.error(
                "Exception not defined in thrift spec was thrown: #{formatted_exception}"
              )

              error =
                Thrift.TApplicationException.exception(
                  type: :internal_error,
                  message: "Server error: #{formatted_exception}"
                )

              {:server_error, error}
          end

        {_, extra} ->
          raise(Thrift.TApplicationException,
            type: :protocol_error,
            message: "Could not decode #{inspect(extra)}"
          )
      end
    end

    def(handle_thrift("trinoGetSplits", binary_data, handler_module)) do
      case(
        Thrift.Generated.TrinoThriftService.TrinoGetSplitsArgs.BinaryProtocol.deserialize(
          binary_data
        )
      ) do
        {%Thrift.Generated.TrinoThriftService.TrinoGetSplitsArgs{
           schema_table_name: schema_table_name,
           desired_columns: desired_columns,
           output_constraint: output_constraint,
           max_split_count: max_split_count,
           next_token: next_token
         }, ""} ->
          try do
            result =
              handler_module.trino_get_splits(
                schema_table_name,
                desired_columns,
                output_constraint,
                max_split_count,
                next_token
              )

            response = %Thrift.Generated.TrinoThriftService.TrinoGetSplitsResponse{
              success: result
            }

            {:reply,
             Thrift.Generated.TrinoThriftService.TrinoGetSplitsResponse.BinaryProtocol.serialize(
               response
             )}
          catch
            :error, %Thrift.Generated.TrinoThriftServiceException{} = ex1 ->
              response = %Thrift.Generated.TrinoThriftService.TrinoGetSplitsResponse{ex1: ex1}

              {:reply,
               Thrift.Generated.TrinoThriftService.TrinoGetSplitsResponse.BinaryProtocol.serialize(
                 response
               )}

            kind, reason ->
              formatted_exception = Exception.format(kind, reason, System.stacktrace())

              Logger.error(
                "Exception not defined in thrift spec was thrown: #{formatted_exception}"
              )

              error =
                Thrift.TApplicationException.exception(
                  type: :internal_error,
                  message: "Server error: #{formatted_exception}"
                )

              {:server_error, error}
          end

        {_, extra} ->
          raise(Thrift.TApplicationException,
            type: :protocol_error,
            message: "Could not decode #{inspect(extra)}"
          )
      end
    end

    def(handle_thrift("trinoGetTableMetadata", binary_data, handler_module)) do
      case(
        Thrift.Generated.TrinoThriftService.TrinoGetTableMetadataArgs.BinaryProtocol.deserialize(
          binary_data
        )
      ) do
        {%Thrift.Generated.TrinoThriftService.TrinoGetTableMetadataArgs{
           schema_table_name: schema_table_name
         }, ""} ->
          try do
            result = handler_module.trino_get_table_metadata(schema_table_name)

            response = %Thrift.Generated.TrinoThriftService.TrinoGetTableMetadataResponse{
              success: result
            }

            {:reply,
             Thrift.Generated.TrinoThriftService.TrinoGetTableMetadataResponse.BinaryProtocol.serialize(
               response
             )}
          catch
            :error, %Thrift.Generated.TrinoThriftServiceException{} = ex1 ->
              response = %Thrift.Generated.TrinoThriftService.TrinoGetTableMetadataResponse{
                ex1: ex1
              }

              {:reply,
               Thrift.Generated.TrinoThriftService.TrinoGetTableMetadataResponse.BinaryProtocol.serialize(
                 response
               )}

            kind, reason ->
              formatted_exception = Exception.format(kind, reason, System.stacktrace())

              Logger.error(
                "Exception not defined in thrift spec was thrown: #{formatted_exception}"
              )

              error =
                Thrift.TApplicationException.exception(
                  type: :internal_error,
                  message: "Server error: #{formatted_exception}"
                )

              {:server_error, error}
          end

        {_, extra} ->
          raise(Thrift.TApplicationException,
            type: :protocol_error,
            message: "Could not decode #{inspect(extra)}"
          )
      end
    end

    def(handle_thrift("trinoListSchemaNames", _binary_data, handler_module)) do
      try do
        result = handler_module.trino_list_schema_names()

        response = %Thrift.Generated.TrinoThriftService.TrinoListSchemaNamesResponse{
          success: result
        }

        {:reply,
         Thrift.Generated.TrinoThriftService.TrinoListSchemaNamesResponse.BinaryProtocol.serialize(
           response
         )}
      catch
        :error, %Thrift.Generated.TrinoThriftServiceException{} = ex1 ->
          response = %Thrift.Generated.TrinoThriftService.TrinoListSchemaNamesResponse{ex1: ex1}

          {:reply,
           Thrift.Generated.TrinoThriftService.TrinoListSchemaNamesResponse.BinaryProtocol.serialize(
             response
           )}

        kind, reason ->
          formatted_exception = Exception.format(kind, reason, System.stacktrace())
          Logger.error("Exception not defined in thrift spec was thrown: #{formatted_exception}")

          error =
            Thrift.TApplicationException.exception(
              type: :internal_error,
              message: "Server error: #{formatted_exception}"
            )

          {:server_error, error}
      end
    end

    def(handle_thrift("trinoListTables", binary_data, handler_module)) do
      case(
        Thrift.Generated.TrinoThriftService.TrinoListTablesArgs.BinaryProtocol.deserialize(
          binary_data
        )
      ) do
        {%Thrift.Generated.TrinoThriftService.TrinoListTablesArgs{
           schema_name_or_null: schema_name_or_null
         }, ""} ->
          try do
            result = handler_module.trino_list_tables(schema_name_or_null)

            response = %Thrift.Generated.TrinoThriftService.TrinoListTablesResponse{
              success: result
            }

            {:reply,
             Thrift.Generated.TrinoThriftService.TrinoListTablesResponse.BinaryProtocol.serialize(
               response
             )}
          catch
            :error, %Thrift.Generated.TrinoThriftServiceException{} = ex1 ->
              response = %Thrift.Generated.TrinoThriftService.TrinoListTablesResponse{ex1: ex1}

              {:reply,
               Thrift.Generated.TrinoThriftService.TrinoListTablesResponse.BinaryProtocol.serialize(
                 response
               )}

            kind, reason ->
              formatted_exception = Exception.format(kind, reason, System.stacktrace())

              Logger.error(
                "Exception not defined in thrift spec was thrown: #{formatted_exception}"
              )

              error =
                Thrift.TApplicationException.exception(
                  type: :internal_error,
                  message: "Server error: #{formatted_exception}"
                )

              {:server_error, error}
          end

        {_, extra} ->
          raise(Thrift.TApplicationException,
            type: :protocol_error,
            message: "Could not decode #{inspect(extra)}"
          )
      end
    end
  end
end
