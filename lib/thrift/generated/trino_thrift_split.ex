defmodule(Thrift.Generated.TrinoThriftSplit) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftSplit"
  _ = "1: TrinoThriftService.TrinoThriftId split_id"
  _ = "2: list<TrinoThriftService.TrinoThriftHostAddress> hosts"
  defstruct(split_id: nil, hosts: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftSplit{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftSplit{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftId.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | split_id: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<15, 2::16-signed, 12, remaining::32-signed, rest::binary>>, struct)) do
      deserialize__hosts(rest, [[], remaining, struct])
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    defp(deserialize__hosts(<<rest::binary>>, [list, 0, struct])) do
      deserialize(rest, %{struct | hosts: Enum.reverse(list)})
    end

    defp(deserialize__hosts(<<rest::binary>>, [list, remaining | stack])) do
      case(Thrift.Generated.TrinoThriftHostAddress.BinaryProtocol.deserialize(rest)) do
        {element, rest} ->
          deserialize__hosts(rest, [[element | list], remaining - 1 | stack])

        :error ->
          :error
      end
    end

    defp(deserialize__hosts(_, _)) do
      :error
    end

    def(serialize(%Thrift.Generated.TrinoThriftSplit{split_id: split_id, hosts: hosts})) do
      [
        case(split_id) do
          nil ->
            <<>>

          _ ->
            [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftId.serialize(split_id)]
        end,
        case(hosts) do
          nil ->
            <<>>

          _ ->
            [
              <<15, 2::16-signed, 12, length(hosts)::32-signed>>
              | for(e <- hosts) do
                  Thrift.Generated.TrinoThriftHostAddress.serialize(e)
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
