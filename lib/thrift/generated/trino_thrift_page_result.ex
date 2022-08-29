defmodule(Thrift.Generated.TrinoThriftPageResult) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftPageResult"
  _ = "1: list<TrinoThriftService.TrinoThriftBlock> column_blocks"
  _ = "2: i32 row_count"
  _ = "3: TrinoThriftService.TrinoThriftId next_token"
  defstruct(column_blocks: nil, row_count: nil, next_token: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftPageResult{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftPageResult{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<15, 1::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__column_blocks(rest, [[], remaining, struct])
    end

    defp(deserialize(<<8, 2::16-signed, value::32-signed, rest::binary>>, acc)) do
      deserialize(rest, %{acc | row_count: value})
    end

    defp(deserialize(<<12, 3::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftId.BinaryProtocol.deserialize(rest)) do
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

    defp(deserialize__column_blocks(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | column_blocks: Enum.reverse(list)})
    end

    defp(deserialize__column_blocks(<<rest::binary>>, [list, remaining | stack])) do
      case(Thrift.Generated.TrinoThriftBlock.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__column_blocks(rest, [[element | list], remaining - 1 | stack])

        :error ->
          :error
      end
    end

    defp(deserialize__column_blocks(_, _)) do
      :error
    end

    def(
      serialize(%Thrift.Generated.TrinoThriftPageResult{
        column_blocks: column_blocks,
        row_count: row_count,
        next_token: next_token
      })
    ) do
      [
        case(column_blocks) do
          nil ->
            <<>>

          _ ->
            [
              <<15, 1::16-signed, 12, length(column_blocks)::32-signed>>
              | for(e <- column_blocks) do
                  Thrift.Generated.TrinoThriftBlock.serialize(e)
                end
            ]
        end,
        case(row_count) do
          nil ->
            <<>>

          _ ->
            <<8, 2::16-signed, row_count::32-signed>>
        end,
        case(next_token) do
          nil ->
            <<>>

          _ ->
            [<<12, 3::16-signed>> | Thrift.Generated.TrinoThriftId.serialize(next_token)]
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
