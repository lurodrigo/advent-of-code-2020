defmodule Day6 do
  def read_input() do
    File.read!("input/day_06.txt")
    |> String.split("\n")
    |> Enum.chunk_by(fn line -> line == "" end)
  end

  def part_1 do
    read_input()
    |> Enum.map(fn responses ->
      responses
      |> Enum.join()
      |> String.to_charlist()
      |> Enum.uniq()
      |> length()
    end)
    |> Enum.sum()
  end

  def part_2() do
    read_input()
    |> Enum.map(fn responses ->
      n = length(responses)

      responses
      |> Enum.join()
      |> String.to_charlist()
      |> Enum.frequencies()
      |> Enum.filter(fn {_, count} -> count == n end)
      |> length()
    end)
    |> Enum.sum()
  end
end
