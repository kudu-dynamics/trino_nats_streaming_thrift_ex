defmodule(Thrift.Generated.TrinoThriftColumnMetadata) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftColumnMetadata"
  _ = "1: string name"
  _ = "2: string type"
  _ = "3: string comment"
  _ = "4: bool hidden"
  defstruct(name: nil, type: nil, comment: nil, hidden: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftColumnMetadata{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftColumnMetadata{} = acc)) do
      {acc, rest}
    end

    defp(
      deserialize(
        <<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size),
          rest::binary>>,
        acc
      )
    ) do
      deserialize(rest, %{acc | name: value})
    end

    defp(
      deserialize(
        <<11, 2::16-signed, string_size::32-signed, value::binary-size(string_size),
          rest::binary>>,
        acc
      )
    ) do
      deserialize(rest, %{acc | type: value})
    end

    defp(
      deserialize(
        <<11, 3::16-signed, string_size::32-signed, value::binary-size(string_size),
          rest::binary>>,
        acc
      )
    ) do
      deserialize(rest, %{acc | comment: value})
    end

    defp(deserialize(<<2, 4::16-signed, 1, rest::binary>>, acc)) do
      deserialize(rest, %{acc | hidden: true})
    end

    defp(deserialize(<<2, 4::16-signed, 0, rest::binary>>, acc)) do
      deserialize(rest, %{acc | hidden: false})
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    def(
      serialize(%Thrift.Generated.TrinoThriftColumnMetadata{
        name: name,
        type: type,
        comment: comment,
        hidden: hidden
      })
    ) do
      [
        case(name) do
          nil ->
            <<>>

          _ ->
            [<<11, 1::16-signed, byte_size(name)::32-signed>> | name]
        end,
        case(type) do
          nil ->
            <<>>

          _ ->
            [<<11, 2::16-signed, byte_size(type)::32-signed>> | type]
        end,
        case(comment) do
          nil ->
            <<>>

          _ ->
            [<<11, 3::16-signed, byte_size(comment)::32-signed>> | comment]
        end,
        case(hidden) do
          nil ->
            <<>>

          false ->
            <<2, 4::16-signed, 0>>

          true ->
            <<2, 4::16-signed, 1>>

          _ ->
            raise(
              Thrift.InvalidValueError,
              "Optional boolean field :hidden on Thrift.Generated.TrinoThriftColumnMetadata must be true, false, or nil"
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
