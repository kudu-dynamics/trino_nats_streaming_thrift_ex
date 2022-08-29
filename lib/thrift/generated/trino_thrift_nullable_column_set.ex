defmodule(Thrift.Generated.TrinoThriftNullableColumnSet) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftNullableColumnSet"
  _ = "1: set<string> columns"
  defstruct(columns: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftNullableColumnSet{})
    end

    defp(
      deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftNullableColumnSet{} = acc)
    ) do
      {acc, rest}
    end

    defp(deserialize(<<14, 1::16-signed, 11, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__columns(rest, [[], remaining, struct])
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    defp(deserialize__columns(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | columns: MapSet.new(list)})
    end

    defp(
      deserialize__columns(
        <<string_size::32-signed, element::binary-size(string_size), rest::binary>>,
        [list, remaining | stack]
      )
    ) do
      deserialize__columns(rest, [[element | list], remaining - 1 | stack])
    end

    defp(deserialize__columns(_, _)) do
      :error
    end

    def(serialize(%Thrift.Generated.TrinoThriftNullableColumnSet{columns: columns})) do
      [
        case(columns) do
          nil ->
            <<>>

          _ ->
            [
              <<14, 1::16-signed, 11, Enum.count(columns)::32-signed>>
              | for(e <- columns) do
                  [<<byte_size(e)::32-signed>> | e]
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
