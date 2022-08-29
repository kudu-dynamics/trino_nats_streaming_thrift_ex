defmodule(Thrift.Generated.TrinoThriftRangeValueSet) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftRangeValueSet"
  _ = "1: list<TrinoThriftService.TrinoThriftRange> ranges"
  defstruct(ranges: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftRangeValueSet{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftRangeValueSet{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<15, 1::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__ranges(rest, [[], remaining, struct])
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    defp(deserialize__ranges(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | ranges: Enum.reverse(list)})
    end

    defp(deserialize__ranges(<<rest::binary>>, [list, remaining | stack])) do
      case(Thrift.Generated.TrinoThriftRange.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__ranges(rest, [[element | list], remaining - 1 | stack])

        :error ->
          :error
      end
    end

    defp(deserialize__ranges(_, _)) do
      :error
    end

    def(serialize(%Thrift.Generated.TrinoThriftRangeValueSet{ranges: ranges})) do
      [
        case(ranges) do
          nil ->
            <<>>

          _ ->
            [
              <<15, 1::16-signed, 12, length(ranges)::32-signed>>
              | for(e <- ranges) do
                  Thrift.Generated.TrinoThriftRange.serialize(e)
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
