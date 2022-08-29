defmodule(Thrift.Generated.TrinoThriftHyperLogLog) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftHyperLogLog"
  _ = "1: list<bool> nulls"
  _ = "2: list<i32> sizes"
  _ = "3: binary bytes"
  defstruct(nulls: nil, sizes: nil, bytes: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftHyperLogLog{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftHyperLogLog{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<15, 1::16-signed, 2, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__nulls(rest, [[], remaining, struct])
    end

    defp(deserialize(<<15, 2::16-signed, 8, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__sizes(rest, [[], remaining, struct])
    end

    defp(
      deserialize(
        <<11, 3::16-signed, string_size::32-signed, value::binary-size(string_size),
          rest::binary>>,
        acc
      )
    ) do
      deserialize(rest, %{acc | bytes: value})
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
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

    defp(deserialize__sizes(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | sizes: Enum.reverse(list)})
    end

    defp(deserialize__sizes(<<element::32-signed, rest::binary>>, [list, remaining | stack])) do
      deserialize__sizes(rest, [[element | list], remaining - 1 | stack])
    end

    defp(deserialize__sizes(_, _)) do
      :error
    end

    def(
      serialize(%Thrift.Generated.TrinoThriftHyperLogLog{nulls: nulls, sizes: sizes, bytes: bytes})
    ) do
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
        case(sizes) do
          nil ->
            <<>>

          _ ->
            [
              <<15, 2::16-signed, 8, length(sizes)::32-signed>>
              | for(e <- sizes) do
                  <<e::32-signed>>
                end
            ]
        end,
        case(bytes) do
          nil ->
            <<>>

          _ ->
            [<<11, 3::16-signed, byte_size(bytes)::32-signed>> | bytes]
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
