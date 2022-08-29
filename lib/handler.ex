defmodule TrinoNatsStreamingThrift.Handler do
  @moduledoc false

  alias Thrift.Generated.{
    TrinoThriftBigint,
    TrinoThriftBlock,
    TrinoThriftColumnMetadata,
    TrinoThriftId,
    TrinoThriftJson,
    TrinoThriftNullableSchemaName,
    TrinoThriftNullableTableMetadata,
    TrinoThriftNullableToken,
    TrinoThriftPageResult,
    TrinoThriftSchemaTableName,
    TrinoThriftService,
    TrinoThriftServiceException,
    TrinoThriftSplit,
    TrinoThriftSplitBatch,
    TrinoThriftTableMetadata,
    TrinoThriftTimestamp,
    TrinoThriftVarchar
  }

  alias TrinoNatsStreamingThrift.{Config, NatsStreaming}

  require Logger

  @behaviour TrinoThriftService.Handler
  @columns [
    {"sequence", "BIGINT"},
    # DEV: Redundant as the table name is the channel.
    # {"subject", "VARCHAR"},
    {"data", "JSON"},
    {"timestamp", "TIMESTAMP"}
  ]

  defp type_to_module("BIGINT"), do: TrinoThriftBigint
  defp type_to_module("JSON"), do: TrinoThriftJson
  defp type_to_module("VARCHAR"), do: TrinoThriftVarchar
  defp type_to_module("TIMESTAMP"), do: TrinoThriftTimestamp

  defp type_to_module(type),
    do:
      raise(%TrinoThriftServiceException{
        message: "Unsupported column type: #{type}",
        retryable: false
      })

  def trino_get_index_splits(
        _schema_table_name,
        _index_column_names,
        _output_column_names,
        _keys,
        _output_constraint,
        _max_split_count,
        _next_token
      ) do
    raise %TrinoThriftServiceException{
      message: "Index join is not supported",
      retryable: false
    }
  end

  def trino_get_rows(%TrinoThriftId{id: split_id}, columns, _max_bytes, _next_token) do
    # Convert rows to columns.
    split_id = :erlang.binary_to_term(split_id)

    Logger.info("Retrieving rows #{Kernel.inspect(split_id)}")

    rows =
      split_id
      |> NatsStreaming.sub()

    column_blocks =
      columns
      |> Enum.map(&List.keyfind(@columns, &1, 0))
      |> Enum.reject(fn x -> x == nil end)
      |> Enum.map(fn {k, v} -> {k, type_to_module(v)} end)
      |> Enum.map(&column_block_init/1)

    column_blocks =
      rows
      |> Enum.reduce(column_blocks, &column_block_add_row/2)
      |> Enum.map(fn {_, v} -> column_block_wrap(v) end)

    Logger.info("Returning #{length(rows)} rows for #{Kernel.inspect(split_id)}")

    %TrinoThriftPageResult{
      column_blocks: column_blocks,
      row_count: length(rows),
      # XXX: Further iterations might support chunking a call to get_rows when
      #      too much data is returned.
      next_token: nil
    }
  end

  defp column_block_init({k, TrinoThriftBigint}),
    do: {k, %TrinoThriftBigint{nulls: [], longs: []}}

  defp column_block_init({k, TrinoThriftJson}),
    do: {k, %TrinoThriftJson{nulls: [], sizes: [], bytes: ""}}

  defp column_block_init({k, TrinoThriftTimestamp}),
    do: {k, %TrinoThriftTimestamp{nulls: [], timestamps: []}}

  defp column_block_wrap(%TrinoThriftBigint{nulls: nulls, longs: longs}) do
    %TrinoThriftBlock{
      bigint_data: %TrinoThriftBigint{
        nulls: Enum.reverse(nulls),
        longs: Enum.reverse(longs)
      }
    }
  end

  defp column_block_wrap(%TrinoThriftJson{nulls: nulls, sizes: sizes, bytes: bytes}) do
    %TrinoThriftBlock{
      json_data: %TrinoThriftJson{
        nulls: Enum.reverse(nulls),
        sizes: Enum.reverse(sizes),
        bytes: bytes
      }
    }
  end

  defp column_block_wrap(%TrinoThriftTimestamp{
         nulls: nulls,
         timestamps: timestamps
       }) do
    %TrinoThriftBlock{
      timestamp_data: %TrinoThriftTimestamp{
        nulls: Enum.reverse(nulls),
        timestamps: Enum.reverse(timestamps)
      }
    }
  end

  defp column_block_add_row(row, column_blocks) do
    column_blocks
    |> Enum.map(fn block -> column_block_add(row, block) end)
  end

  defp column_block_add(
         %{"sequence" => nil},
         {"sequence", %TrinoThriftBigint{nulls: nulls, longs: longs}}
       ) do
    {"sequence",
     %TrinoThriftBigint{
       nulls: [true | nulls],
       longs: [0 | longs]
     }}
  end

  defp column_block_add(
         %{"sequence" => sequence},
         {"sequence", %TrinoThriftBigint{nulls: nulls, longs: longs}}
       ) do
    {"sequence",
     %TrinoThriftBigint{
       nulls: [false | nulls],
       longs: [sequence | longs]
     }}
  end

  defp column_block_add(
         %{"data" => nil},
         {"data", %TrinoThriftJson{nulls: nulls, sizes: sizes, bytes: bytes}}
       ) do
    {"data",
     %TrinoThriftJson{
       nulls: [true | nulls],
       sizes: [0 | sizes],
       bytes: bytes
     }}
  end

  defp column_block_add(
         %{"data" => data},
         {"data", %TrinoThriftJson{nulls: nulls, sizes: sizes, bytes: bytes}}
       ) do
    {"data",
     %TrinoThriftJson{
       nulls: [false | nulls],
       sizes: [String.length(data) | sizes],
       bytes: bytes <> data
     }}
  end

  defp column_block_add(
         _payload,
         {"data", %TrinoThriftJson{nulls: nulls, sizes: sizes, bytes: bytes}}
       ) do
    # DEV: happens when the payload does not contain any data.
    {"data",
     %TrinoThriftJson{
       nulls: [true | nulls],
       sizes: [0 | sizes],
       bytes: bytes
     }}
  end

  defp column_block_add(
         %{"timestamp" => nil},
         {"timestamp", %TrinoThriftTimestamp{nulls: nulls, timestamps: timestamps}}
       ) do
    {"timestamp",
     %TrinoThriftTimestamp{
       nulls: [true | nulls],
       timestamps: [0 | timestamps]
     }}
  end

  defp column_block_add(
         %{"timestamp" => timestamp},
         {"timestamp", %TrinoThriftTimestamp{nulls: nulls, timestamps: timestamps}}
       ) do
    # DEV: Provided timestamps are in nanoseconds. Convert to milliseconds.
    timestamp_ms = div(timestamp, 1_000_000)

    {"timestamp",
     %TrinoThriftTimestamp{
       nulls: [false | nulls],
       timestamps: [timestamp_ms | timestamps]
     }}
  end

  def trino_get_splits(
        schema_table_name,
        _desired_columns,
        _output_constraint,
        max_split_count,
        next_token
      ) do
    # Calculate the number of splits needed. Adjusting down to the limit if
    # necessary.
    info = table_info(schema_table_name)
    msg_count = Map.get(info, "msgs")
    first_seq = Map.get(info, "first_seq")
    last_seq = Map.get(info, "last_seq")

    split_index_lower =
      case next_token do
        nil -> 0
        %TrinoThriftNullableToken{token: nil} -> 0
        %TrinoThriftNullableToken{token: token} -> :erlang.binary_to_term(token.id)
      end

    split_index_upper =
      div(msg_count, Config.split_size())
      |> min(max_split_count - 1)

    to_seq = fn i -> first_seq + i * Config.split_size() end
    lowest_seq = to_seq.(split_index_lower)

    # This range is inclusive.
    splits =
      split_index_lower..split_index_upper
      |> Enum.map(fn i ->
        [
          {"lower", to_seq.(i)},
          {"upper", (to_seq.(i + 1) - 1) |> min(last_seq)},
          {"cluster_id", Map.get(info, "cluster_id")},
          {"channel", Map.get(info, "name")}
        ]
        |> Map.new()
      end)
      # Reject backwards range values.
      |> Enum.reject(fn %{"lower" => lower} -> lower < lowest_seq end)
      # Reject sequence values past the end of possible messages.
      |> Enum.reject(fn %{"lower" => lower} -> lower > last_seq end)

    next_token =
      case Enum.at(splits, -1) do
        # All splits are accounted for.
        nil -> nil
        %{upper: ^last_seq} -> nil
        # More splits will be assembled in the next batch.
        _ -> %TrinoThriftId{id: :erlang.term_to_binary(split_index_upper + 1)}
      end

    %TrinoThriftSplitBatch{
      splits:
        splits
        |> Enum.map(fn split ->
          %TrinoThriftSplit{
            split_id: %TrinoThriftId{id: :erlang.term_to_binary(split)},
            hosts: []
          }
        end),
      next_token: next_token
    }
  end

  @doc """
  Each table has a static set of columns.

  To get data, apply parsing functions to the data column.

  Note: this does not check if the provided schema_table_name is valid.
  """

  def trino_get_table_metadata(schema_table_name) do
    metadata = %TrinoThriftTableMetadata{
      schema_table_name: schema_table_name,
      columns:
        @columns
        |> Enum.map(fn {n, t} ->
          %TrinoThriftColumnMetadata{name: n, type: t}
        end)
    }

    %TrinoThriftNullableTableMetadata{table_metadata: metadata}
  end

  @doc """
  Each connected NATS Streaming cluster ID is mapped as a separate schema name.
  """

  def trino_list_schema_names do
    get_schemas()
    |> Enum.map(fn {_, cluster_id} -> sanitize(cluster_id) end)
  end

  @doc """
  Each connected NATS Streaming channel is mapped as a separate table name.

  DEV: For initial simplicity, assume that each NATS Streaming channel contains
       only JSON messages.
  """

  def trino_list_tables(%TrinoThriftNullableSchemaName{schema_name: schema_name}) do
    schema_name
    |> List.wrap()
    |> get_tables()
    |> Enum.map(fn {{_, k}, v} ->
      %TrinoThriftSchemaTableName{schema_name: sanitize(k), table_name: sanitize(v)}
    end)
  end

  # Private functions.

  @spec get_schemas() :: [{String.t(), String.t()}]

  defp get_schemas do
    Config.stan_urls()
    |> Enum.map(fn url ->
      url
      |> NatsStreaming.cluster_id()
      |> case do
        {:ok, url, cluster_id} ->
          {url, cluster_id}

        _ ->
          raise %TrinoThriftServiceException{
            message: "Could not retrieve schema names",
            retryable: true
          }
      end
    end)
  end

  @spec get_tables(nil | [String.t()]) :: [{{String.t(), String.t()}, String.t()}]

  defp get_tables([]), do: get_tables(nil)
  defp get_tables([nil]), do: get_tables(nil)

  defp get_tables(schemas) do
    # Get the list of valid schema names and create a map to the corresponding
    # cluster's monitoring URL.
    schema_map =
      get_schemas()
      |> Enum.map(fn {url, cluster_id} -> {cluster_id, url} end)
      |> Map.new()

    # Align the schemas that may be normalized to raw schema names.
    case schemas do
      nil ->
        Map.keys(schema_map)

      _ ->
        schemas
        |> Enum.flat_map(fn sanitized_name ->
          schema_map
          |> Enum.filter(&sanitized_match(elem(&1, 0), sanitized_name))
          |> Enum.map(&elem(&1, 0))
        end)
    end
    |> Enum.flat_map(fn schema_name ->
      schema_map
      |> Map.get(schema_name)
      |> NatsStreaming.channels()
      |> case do
        {:ok, url, channels} ->
          [{url, schema_name}]
          |> Stream.cycle()
          |> Enum.zip(channels)

        _ ->
          raise %TrinoThriftServiceException{
            message: "Could not retrieve table names",
            retryable: true
          }
      end
    end)
  end

  defp sanitize(name) do
    name
    |> String.replace(".", "_")
    |> String.replace("-", "_")
  end

  defp sanitized_match(raw_name, sanitized_name) do
    sanitize(raw_name) == sanitized_name
  end

  @spec table_info(%TrinoThriftSchemaTableName{}) :: map()

  defp table_info(schema_table_name) do
    schema_name = schema_table_name.schema_name
    table_name = schema_table_name.table_name

    # Schema and table name values are normalized to strings that Trino supports.
    # This function attempts to find the denormalized matching table and supply
    # its metadata.
    matches =
      get_tables([schema_name])
      |> Enum.filter(fn {{_, _}, v} -> sanitize(v) == table_name end)

    if length(matches) < 1 do
      raise %TrinoThriftServiceException{
        message: "Could not locate #{schema_name}.#{table_name}",
        retryable: false
      }
    end

    {{url, schema_name}, table_name} = Enum.at(matches, 0)

    {:ok, _, body} = NatsStreaming.channel(url, table_name)

    body
    |> Map.put("cluster_id", schema_name)
  end
end
