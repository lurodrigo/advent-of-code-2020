defmodule Day3 do
  def read do
    File.read!("input/day_03.txt")
    |> String.split("\n")
  end

  def count_trees(map, right, down) do
    width = String.length(hd(map))

    map
    |> Enum.take_every(down)
    |> Enum.with_index()
    |> Enum.map(fn {s, i} -> String.at(s, rem(right * i, width)) end)
    |> Enum.filter(&(&1 == "#"))
    |> length()
  end

  def part_1() do
    map = read()

    count_trees(map, 3, 1)
  end

  def part_2() do
    map = read()

    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(fn {right, down} -> count_trees(map, right, down) end)
    |> Enum.reduce(&*/2)
  end
end
