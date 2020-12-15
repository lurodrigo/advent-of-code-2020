defmodule Day5 do
  def read_input() do
    File.read!("input/day_05.txt")
    |> String.split("\n")
    |> Enum.map(&calc_id/1)
  end

  def calc_id(s) do
    s
    |> String.to_charlist()
    |> Enum.reduce(0, fn
      x, acc when x == ?B or x == ?R -> 2 * acc + 1
      _, acc -> 2 * acc
    end)
  end

  def part_1 do
    read_input()
    |> Enum.max()
  end

  def part_2 do
    ids =
      read_input()
      |> Enum.map(fn id -> {id, nil} end)
      |> Enum.into(%{})

    8..1016
    |> Enum.filter(fn id ->
      Map.has_key?(ids, id - 1) and Map.has_key?(ids, id + 1) and not Map.has_key?(ids, id)
    end)
    |> Enum.at(0)
  end
end
