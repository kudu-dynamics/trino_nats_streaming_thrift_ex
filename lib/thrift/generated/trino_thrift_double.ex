defmodule(Thrift.Generated.TrinoThriftDouble) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftDouble"
  _ = "1: list<bool> nulls"
  _ = "2: list<double> doubles"
  defstruct(nulls: nil, doubles: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftDouble{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftDouble{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<15, 1::16-signed, 2, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__nulls(rest, [[], remaining, struct])
    end

    defp(deserialize(<<15, 2::16-signed, 4, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__doubles(rest, [[], remaining, struct])
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    defp(deserialize__doubles(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | doubles: Enum.reverse(list)})
    end

    defp(
      deserialize__doubles(<<0::1, 2047::11, 0::52, rest::binary>>, [list, remaining | stack])
    ) do
      deserialize__doubles(rest, [[:inf | list], remaining - 1 | stack])
    end

    defp(
      deserialize__doubles(<<1::1, 2047::11, 0::52, rest::binary>>, [list, remaining | stack])
    ) do
      deserialize__doubles(rest, [[:"-inf" | list], remaining - 1 | stack])
    end

    defp(
      deserialize__doubles(<<sign::1, 2047::11, frac::52, rest::binary>>, [
        list,
        remaining | stack
      ])
    ) do
      deserialize__doubles(rest, [
        [%Thrift.NaN{sign: sign, fraction: frac} | list],
        remaining - 1 | stack
      ])
    end

    defp(
      deserialize__doubles(<<element::signed-float, rest::binary>>, [list, remaining | stack])
    ) do
      deserialize__doubles(rest, [[element | list], remaining - 1 | stack])
    end

    defp(deserialize__doubles(_, _)) do
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

    def(serialize(%Thrift.Generated.TrinoThriftDouble{nulls: nulls, doubles: doubles})) do
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
        case(doubles) do
          nil ->
            <<>>

          _ ->
            [
              <<15, 2::16-signed, 4, length(doubles)::32-signed>>
              | for(e <- doubles) do
                  case(e) do
                    :inf ->
                      <<0::1, 2047::11, 0::52>>

                    :"-inf" ->
                      <<1::1, 2047::11, 0::52>>

                    %Thrift.NaN{sign: sign, fraction: frac} ->
                      <<sign::1, 2047::11, frac::52>>

                    _ ->
                      <<e::float-signed>>
                  end
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
