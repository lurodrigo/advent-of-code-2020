defmodule Day3 do
  def read_input() do
    File.read!("input/day_03.txt")
    |> String.split("\n")
  end

  def count_trees(grid, right, down) do
    width = String.length(hd(grid))

    grid
    |> Enum.take_every(down)
    |> Enum.with_index()
    |> Enum.map(fn {row, index} -> String.at(row, rem(right * index, width)) end)
    |> Enum.filter(&(&1 == "#"))
    |> length()
  end

  def part_1() do
    read_input()
    |> count_trees(3, 1)
  end

  def part_2() do
    map = read_input()

    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(fn {right, down} -> count_trees(map, right, down) end)
    |> Enum.reduce(&*/2)
  end
end
