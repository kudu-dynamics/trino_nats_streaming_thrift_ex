defmodule(Thrift.Generated.TrinoThriftServiceException) do
  @moduledoc false
  _ = "Auto-generated Thrift exception TrinoThriftService.TrinoThriftServiceException"
  _ = "1: string message"
  _ = "2: bool retryable"
  defexception(message: nil, retryable: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftServiceException{})
    end

    defp(
      deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftServiceException{} = acc)
    ) do
      {acc, rest}
    end

    defp(
      deserialize(
        <<11, 1::16-signed, string_size::32-signed, value::binary-size(string_size),
          rest::binary>>,
        acc
      )
    ) do
      deserialize(rest, %{acc | message: value})
    end

    defp(deserialize(<<2, 2::16-signed, 1, rest::binary>>, acc)) do
      deserialize(rest, %{acc | retryable: true})
    end

    defp(deserialize(<<2, 2::16-signed, 0, rest::binary>>, acc)) do
      deserialize(rest, %{acc | retryable: false})
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    def(
      serialize(%Thrift.Generated.TrinoThriftServiceException{
        message: message,
        retryable: retryable
      })
    ) do
      [
        case(message) do
          nil ->
            <<>>

          _ ->
            [<<11, 1::16-signed, byte_size(message)::32-signed>> | message]
        end,
        case(retryable) do
          nil ->
            <<>>

          false ->
            <<2, 2::16-signed, 0>>

          true ->
            <<2, 2::16-signed, 1>>

          _ ->
            raise(
              Thrift.InvalidValueError,
              "Optional boolean field :retryable on Thrift.Generated.TrinoThriftServiceException must be true, false, or nil"
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
