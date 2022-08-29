defmodule(Thrift.Generated.TrinoThriftTupleDomain) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftTupleDomain"
  _ = "1: map<string,TrinoThriftService.TrinoThriftDomain> domains"
  defstruct(domains: nil)
  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftTupleDomain{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftTupleDomain{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<13, 1::16-signed, 11, 12, map_size::32-signed, rest::binary>>, struct)) do
      deserialize__domains__key(rest, [%{}, map_size, struct])
    end

    defp(deserialize(<<field_type, _id::16-signed, rest::binary>>, acc)) do
      rest |> Thrift.Protocol.Binary.skip_field(field_type) |> deserialize(acc)
    end

    defp(deserialize(_, _)) do
      :error
    end

    defp(deserialize__domains__key(<<rest::binary>>, [map, 0, struct])) do
      deserialize(rest, %{struct | domains: map})
    end

    defp(
      deserialize__domains__key(
        <<string_size::32-signed, key::binary-size(string_size), rest::binary>>,
        stack
      )
    ) do
      deserialize__domains__value(rest, key, stack)
    end

    defp(deserialize__domains__key(_, _)) do
      :error
    end

    defp(deserialize__domains__value(<<rest::binary>>, key, [map, remaining | stack])) do
      case(Thrift.Generated.TrinoThriftDomain.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize__domains__key(rest, [Map.put(map, key, value), remaining - 1 | stack])

        :error ->
          :error
      end
    end

    defp(deserialize__domains__value(_, _, _)) do
      :error
    end

    def(serialize(%Thrift.Generated.TrinoThriftTupleDomain{domains: domains})) do
      [
        case(domains) do
          nil ->
            <<>>

          _ ->
            [
              <<13, 1::16-signed, 11, 12, Enum.count(domains)::32-signed>>
              | for({k, v} <- domains) do
                  [
                    <<byte_size(k)::32-signed>>,
                    k | Thrift.Generated.TrinoThriftDomain.serialize(v)
                  ]
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
