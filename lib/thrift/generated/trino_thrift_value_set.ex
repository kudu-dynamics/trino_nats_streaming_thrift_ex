defmodule(Thrift.Generated.TrinoThriftValueSet) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftValueSet"
  _ = "1: TrinoThriftService.TrinoThriftAllOrNoneValueSet all_or_none_value_set"
  _ = "2: TrinoThriftService.TrinoThriftEquatableValueSet equatable_value_set"
  _ = "3: TrinoThriftService.TrinoThriftRangeValueSet range_value_set"
  defstruct(all_or_none_value_set: nil, equatable_value_set: nil, range_value_set: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftValueSet{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftValueSet{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftAllOrNoneValueSet.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | all_or_none_value_set: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 2::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftEquatableValueSet.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | equatable_value_set: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 3::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftRangeValueSet.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | range_value_set: value})

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

    def(
      serialize(%Thrift.Generated.TrinoThriftValueSet{
        all_or_none_value_set: all_or_none_value_set,
        equatable_value_set: equatable_value_set,
        range_value_set: range_value_set
      })
    ) do
      [
        case(all_or_none_value_set) do
          nil ->
            <<>>

          _ ->
            [
              <<12, 1::16-signed>>
              | Thrift.Generated.TrinoThriftAllOrNoneValueSet.serialize(all_or_none_value_set)
            ]
        end,
        case(equatable_value_set) do
          nil ->
            <<>>

          _ ->
            [
              <<12, 2::16-signed>>
              | Thrift.Generated.TrinoThriftEquatableValueSet.serialize(equatable_value_set)
            ]
        end,
        case(range_value_set) do
          nil ->
            <<>>

          _ ->
            [
              <<12, 3::16-signed>>
              | Thrift.Generated.TrinoThriftRangeValueSet.serialize(range_value_set)
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
