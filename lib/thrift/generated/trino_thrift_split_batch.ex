defmodule(Thrift.Generated.TrinoThriftSplitBatch) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftSplitBatch"
  _ = "1: list<TrinoThriftService.TrinoThriftSplit> splits"
  _ = "2: TrinoThriftService.TrinoThriftId next_token"
  defstruct(splits: nil, next_token: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftSplitBatch{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftSplitBatch{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<15, 1::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__splits(rest, [[], remaining, struct])
    end

    defp(deserialize(<<12, 2::16-signed, rest::binary>>, acc)) do
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

    defp(deserialize__splits(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | splits: Enum.reverse(list)})
    end

    defp(deserialize__splits(<<rest::binary>>, [list, remaining | stack])) do
      case(Thrift.Generated.TrinoThriftSplit.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__splits(rest, [[element | list], remaining - 1 | stack])

        :error ->
          :error
      end
    end

    defp(deserialize__splits(_, _)) do
      :error
    end

    def(
      serialize(%Thrift.Generated.TrinoThriftSplitBatch{splits: splits, next_token: next_token})
    ) do
      [
        case(splits) do
          nil ->
            <<>>

          _ ->
            [
              <<15, 1::16-signed, 12, length(splits)::32-signed>>
              | for(e <- splits) do
                  Thrift.Generated.TrinoThriftSplit.serialize(e)
                end
            ]
        end,
        case(next_token) do
          nil ->
            <<>>

          _ ->
            [<<12, 2::16-signed>> | Thrift.Generated.TrinoThriftId.serialize(next_token)]
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
