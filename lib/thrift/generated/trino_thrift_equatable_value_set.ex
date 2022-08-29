defmodule(Thrift.Generated.TrinoThriftEquatableValueSet) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftEquatableValueSet"
  _ = "1: bool inclusive"
  _ = "2: list<TrinoThriftService.TrinoThriftBlock> values"
  defstruct(inclusive: nil, values: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftEquatableValueSet{})
    end

    defp(
      deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftEquatableValueSet{} = acc)
    ) do
      {acc, rest}
    end

    defp(deserialize(<<2, 1::16-signed, 1, rest::binary>>, acc)) do
      deserialize(rest, %{acc | inclusive: true})
    end

    defp(deserialize(<<2, 1::16-signed, 0, rest::binary>>, acc)) do
      deserialize(rest, %{acc | inclusive: false})
    end

    defp(deserialize(<<15, 2::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__values(rest, [[], remaining, struct])
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    defp(deserialize__values(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | values: Enum.reverse(list)})
    end

    defp(deserialize__values(<<rest::binary>>, [list, remaining | stack])) do
      case(Thrift.Generated.TrinoThriftBlock.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__values(rest, [[element | list], remaining - 1 | stack])

        :error ->
          :error
      end
    end

    defp(deserialize__values(_, _)) do
      :error
    end

    def(
      serialize(%Thrift.Generated.TrinoThriftEquatableValueSet{
        inclusive: inclusive,
        values: values
      })
    ) do
      [
        case(inclusive) do
          nil ->
            <<>>

          false ->
            <<2, 1::16-signed, 0>>

          true ->
            <<2, 1::16-signed, 1>>

          _ ->
            raise(
              Thrift.InvalidValueError,
              "Optional boolean field :inclusive on Thrift.Generated.TrinoThriftEquatableValueSet must be true, false, or nil"
            )
        end,
        case(values) do
          nil ->
            <<>>

          _ ->
            [
              <<15, 2::16-signed, 12, length(values)::32-signed>>
              | for(e <- values) do
                  Thrift.Generated.TrinoThriftBlock.serialize(e)
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
