defmodule(Thrift.Generated.TrinoThriftBound) do
  @moduledoc false
  defmacro(unquote(:below)()) do
    1
  end

  defmacro(unquote(:exactly)()) do
    2
  end

  defmacro(unquote(:above)()) do
    3
  end

  def(value_to_name(v)) do
    case(v) do
      1 ->
        {:ok, :below}

      2 ->
        {:ok, :exactly}

      3 ->
        {:ok, :above}

      _ ->
        {:error, {:invalid_enum_value, v}}
    end
  end

  def(name_to_value(k)) do
    case(k) do
      :below ->
        {:ok, 1}

      :exactly ->
        {:ok, 2}

      :above ->
        {:ok, 3}

      _ ->
        {:error, {:invalid_enum_name, k}}
    end
  end

  def(value_to_name!(value)) do
    {:ok, name} = value_to_name(value)
    name
  end

  def(name_to_value!(name)) do
    {:ok, value} = name_to_value(name)
    value
  end

  def(meta(:names)) do
    [:below, :exactly, :above]
  end

  def(meta(:values)) do
    [1, 2, 3]
  end

  def(member?(v)) do
    case(v) do
      1 ->
        true

      2 ->
        true

      3 ->
        true

      _ ->
        false
    end
  end

  def(name?(k)) do
    case(k) do
      :below ->
        true

      :exactly ->
        true

      :above ->
        true

      _ ->
        false
    end
  end
end
