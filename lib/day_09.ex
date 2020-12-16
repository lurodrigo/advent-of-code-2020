defmodule Day9 do
  def read_input() do
    File.read!("input/day_09.txt")
    |> String.split("\n")
    |> Enum.map(&:erlang.binary_to_integer/1)
  end

  def possible?(l, n) do
    possible =
      for x <- l, y <- l, x != y do
        x + y
      end

    n in possible
  end

  def find_first(input, pos) do
    value = Enum.at(input, pos)
    prev = Enum.slice(input, pos - 25, 25)

    if not possible?(prev, value) do
      value
    else
      find_first(input, pos + 1)
    end
  end

  def part_1 do
    read_input()
    |> find_first(25)
  end

  def part_2 do
    result = part_1()
    input = read_input()

    [sum] =
      for i <- 0..(length(input) - 1),
          l <- 2..(length(input) - i),
          result == (slice = Enum.slice(input, i, l)) |> Enum.sum() do
        Enum.min(slice) + Enum.max(slice)
      end

    sum
  end
end
