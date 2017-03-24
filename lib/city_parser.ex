defmodule CityParser do
  @moduledoc """
  Documentation for CityParser.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CityParser.hello
      :world

  """
  def cities do
    stream = File.stream!("lib/cities.csv", [:utf8])

    stream
    |> CSV.decode
    |> Enum.take(20000)
    |> Enum.map(&encode_struct/1)
  end

  def city_struct(item) do
    [
      country: Enum.at(item, 0),
      city: Enum.at(item, 1),
      region: Enum.at(item, 3),
      population: Enum.at(item, 4),
      lat: Enum.at(item, 5),
      lon: Enum.at(item, 6)
    ]
  end

  def encode_struct(item) do
    {_, result} = JSON.encode(city_struct(item))
    result
  end
end
