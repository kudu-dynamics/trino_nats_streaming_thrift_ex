defmodule(Thrift.Generated.TrinoThriftService.Handler) do
  @moduledoc false
  (
    @callback trino_get_index_splits(
                schema_table_name :: %Thrift.Generated.TrinoThriftSchemaTableName{},
                index_column_names :: [String.t()],
                output_column_names :: [String.t()],
                keys :: %Thrift.Generated.TrinoThriftPageResult{},
                output_constraint :: %Thrift.Generated.TrinoThriftTupleDomain{},
                max_split_count :: Thrift.i32(),
                next_token :: %Thrift.Generated.TrinoThriftNullableToken{}
              ) :: %Thrift.Generated.TrinoThriftSplitBatch{}
    @callback trino_get_rows(
                split_id :: %Thrift.Generated.TrinoThriftId{},
                columns :: [String.t()],
                max_bytes :: Thrift.i64(),
                next_token :: %Thrift.Generated.TrinoThriftNullableToken{}
              ) :: %Thrift.Generated.TrinoThriftPageResult{}
    @callback trino_get_splits(
                schema_table_name :: %Thrift.Generated.TrinoThriftSchemaTableName{},
                desired_columns :: %Thrift.Generated.TrinoThriftNullableColumnSet{},
                output_constraint :: %Thrift.Generated.TrinoThriftTupleDomain{},
                max_split_count :: Thrift.i32(),
                next_token :: %Thrift.Generated.TrinoThriftNullableToken{}
              ) :: %Thrift.Generated.TrinoThriftSplitBatch{}
    @callback trino_get_table_metadata(
                schema_table_name :: %Thrift.Generated.TrinoThriftSchemaTableName{}
              ) :: %Thrift.Generated.TrinoThriftNullableTableMetadata{}
    @callback trino_list_schema_names() :: [String.t()]
    @callback trino_list_tables(
                schema_name_or_null :: %Thrift.Generated.TrinoThriftNullableSchemaName{}
              ) :: [%Thrift.Generated.TrinoThriftSchemaTableName{}]
  )
end
