defmodule(Thrift.Generated.TrinoThriftDomain) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftDomain"
  _ = "1: TrinoThriftService.TrinoThriftValueSet value_set"
  _ = "2: bool null_allowed"
  defstruct(value_set: nil, null_allowed: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftDomain{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftDomain{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftValueSet.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | value_set: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<2, 2::16-signed, 1, rest::binary>>, acc)) do
      deserialize(rest, %{acc | null_allowed: true})
    end

    defp(deserialize(<<2, 2::16-signed, 0, rest::binary>>, acc)) do
      deserialize(rest, %{acc | null_allowed: false})
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    def(
      serialize(%Thrift.Generated.TrinoThriftDomain{
        value_set: value_set,
        null_allowed: null_allowed
      })
    ) do
      [
        case(value_set) do
          nil ->
            <<>>

          _ ->
            [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftValueSet.serialize(value_set)]
        end,
        case(null_allowed) do
          nil ->
            <<>>

          false ->
            <<2, 2::16-signed, 0>>

          true ->
            <<2, 2::16-signed, 1>>

          _ ->
            raise(
              Thrift.InvalidValueError,
              "Optional boolean field :null_allowed on Thrift.Generated.TrinoThriftDomain must be true, false, or nil"
            )
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
