defmodule(Thrift.Generated.TrinoThriftBigint) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftBigint"
  _ = "1: list<bool> nulls"
  _ = "2: list<i64> longs"
  defstruct(nulls: nil, longs: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftBigint{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftBigint{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<15, 1::16-signed, 2, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__nulls(rest, [[], remaining, struct])
    end

    defp(deserialize(<<15, 2::16-signed, 10, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__longs(rest, [[], remaining, struct])
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    defp(deserialize__longs(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | longs: Enum.reverse(list)})
    end

    defp(deserialize__longs(<<element::64-signed, rest::binary>>, [list, remaining | stack])) do
      deserialize__longs(rest, [[element | list], remaining - 1 | stack])
    end

    defp(deserialize__longs(_, _)) do
      :error
    end

    defp(deserialize__nulls(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | nulls: Enum.reverse(list)})
    end

    defp(deserialize__nulls(<<0, rest::binary>>, [list, remaining | stack])) do
      deserialize__nulls(rest, [[false | list], remaining - 1 | stack])
    end

    defp(deserialize__nulls(<<1, rest::binary>>, [list, remaining | stack])) do
      deserialize__nulls(rest, [[true | list], remaining - 1 | stack])
    end

    defp(deserialize__nulls(_, _)) do
      :error
    end

    def(serialize(%Thrift.Generated.TrinoThriftBigint{nulls: nulls, longs: longs})) do
      [
        case(nulls) do
          nil ->
            <<>>

          _ ->
            [
              <<15, 1::16-signed, 2, length(nulls)::32-signed>>
              | for(e <- nulls) do
                  case(e) do
                    nil ->
                      <<0>>

                    false ->
                      <<0>>

                    _ ->
                      <<1>>
                  end
                end
            ]
        end,
        case(longs) do
          nil ->
            <<>>

          _ ->
            [
              <<15, 2::16-signed, 10, length(longs)::32-signed>>
              | for(e <- longs) do
                  <<e::64-signed>>
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
