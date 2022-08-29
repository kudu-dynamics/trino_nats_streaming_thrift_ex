defmodule(Thrift.Generated.TrinoThriftBlock) do
  @moduledoc false
  _ = "Auto-generated Thrift struct TrinoThriftService.TrinoThriftBlock"
  _ = "1: TrinoThriftService.TrinoThriftInteger integer_data"
  _ = "2: TrinoThriftService.TrinoThriftBigint bigint_data"
  _ = "3: TrinoThriftService.TrinoThriftDouble double_data"
  _ = "4: TrinoThriftService.TrinoThriftVarchar varchar_data"
  _ = "5: TrinoThriftService.TrinoThriftBoolean boolean_data"
  _ = "6: TrinoThriftService.TrinoThriftDate date_data"
  _ = "7: TrinoThriftService.TrinoThriftTimestamp timestamp_data"
  _ = "8: TrinoThriftService.TrinoThriftJson json_data"
  _ = "9: TrinoThriftService.TrinoThriftHyperLogLog hyper_log_log_data"
  _ = "10: TrinoThriftService.TrinoThriftBigintArray bigint_array_data"

  defstruct(
    integer_data: nil,
    bigint_data: nil,
    double_data: nil,
    varchar_data: nil,
    boolean_data: nil,
    date_data: nil,
    timestamp_data: nil,
    json_data: nil,
    hyper_log_log_data: nil,
    bigint_array_data: nil
  )

  @type t :: %__MODULE__{}
  def(new) do
    %__MODULE__{}
  end

  defmodule(BinaryProtocol) do
    @moduledoc false
    def(deserialize(binary)) do
      deserialize(binary, %Thrift.Generated.TrinoThriftBlock{})
    end

    defp(deserialize(<<0, rest::binary>>, %Thrift.Generated.TrinoThriftBlock{} = acc)) do
      {acc, rest}
    end

    defp(deserialize(<<12, 1::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftInteger.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | integer_data: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 2::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftBigint.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | bigint_data: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 3::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftDouble.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | double_data: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 4::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftVarchar.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | varchar_data: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 5::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftBoolean.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | boolean_data: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 6::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftDate.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | date_data: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 7::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftTimestamp.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | timestamp_data: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 8::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftJson.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | json_data: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 9::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftHyperLogLog.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | hyper_log_log_data: value})

        :error ->
          :error
      end
    end

    defp(deserialize(<<12, 10::16-signed, rest::binary>>, acc)) do
      case(Thrift.Generated.TrinoThriftBigintArray.BinaryProtocol.deserialize(rest)) do
        {value, rest} ->
          deserialize(rest, %{acc | bigint_array_data: value})

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
      serialize(%Thrift.Generated.TrinoThriftBlock{
        integer_data: integer_data,
        bigint_data: bigint_data,
        double_data: double_data,
        varchar_data: varchar_data,
        boolean_data: boolean_data,
        date_data: date_data,
        timestamp_data: timestamp_data,
        json_data: json_data,
        hyper_log_log_data: hyper_log_log_data,
        bigint_array_data: bigint_array_data
      })
    ) do
      [
        case(integer_data) do
          nil ->
            <<>>

          _ ->
            [<<12, 1::16-signed>> | Thrift.Generated.TrinoThriftInteger.serialize(integer_data)]
        end,
        case(bigint_data) do
          nil ->
            <<>>

          _ ->
            [<<12, 2::16-signed>> | Thrift.Generated.TrinoThriftBigint.serialize(bigint_data)]
        end,
        case(double_data) do
          nil ->
            <<>>

          _ ->
            [<<12, 3::16-signed>> | Thrift.Generated.TrinoThriftDouble.serialize(double_data)]
        end,
        case(varchar_data) do
          nil ->
            <<>>

          _ ->
            [<<12, 4::16-signed>> | Thrift.Generated.TrinoThriftVarchar.serialize(varchar_data)]
        end,
        case(boolean_data) do
          nil ->
            <<>>

          _ ->
            [<<12, 5::16-signed>> | Thrift.Generated.TrinoThriftBoolean.serialize(boolean_data)]
        end,
        case(date_data) do
          nil ->
            <<>>

          _ ->
            [<<12, 6::16-signed>> | Thrift.Generated.TrinoThriftDate.serialize(date_data)]
        end,
        case(timestamp_data) do
          nil ->
            <<>>

          _ ->
            [
              <<12, 7::16-signed>>
              | Thrift.Generated.TrinoThriftTimestamp.serialize(timestamp_data)
            ]
        end,
        case(json_data) do
          nil ->
            <<>>

          _ ->
            [<<12, 8::16-signed>> | Thrift.Generated.TrinoThriftJson.serialize(json_data)]
        end,
        case(hyper_log_log_data) do
          nil ->
            <<>>

          _ ->
            [
              <<12, 9::16-signed>>
              | Thrift.Generated.TrinoThriftHyperLogLog.serialize(hyper_log_log_data)
            ]
        end,
        case(bigint_array_data) do
          nil ->
            <<>>

          _ ->
            [
              <<12, 10::16-signed>>
              | Thrift.Generated.TrinoThriftBigintArray.serialize(bigint_array_data)
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
