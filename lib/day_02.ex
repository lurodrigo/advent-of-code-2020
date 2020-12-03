defmodule Day2 do
  def parse_line(line) do
    [_, num_1, num_2, letter, pwd] = Regex.run(~r/(\d+)-(\d+) (\w): (\w+)/, line)
    [:erlang.binary_to_integer(num_1), :erlang.binary_to_integer(num_2), letter, pwd]
  end

  def read do
    File.read!("input/day_02.txt")
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  def valid_1([min, max, letter, pwd]) do
    count =
      pwd
      |> String.graphemes()
      |> Enum.filter(fn char -> char == letter end)
      |> length()

    count >= min and count <= max
  end

  def part_1 do
    read()
    |> Enum.filter(&valid_1/1)
    |> length()
  end

  def valid_2([pos_1, pos_2, letter, pwd]) do
    at_1 = String.at(pwd, pos_1 - 1) == letter
    at_2 = String.at(pwd, pos_2 - 1) == letter

    (at_1 and not at_2) or (not at_1 and at_2)
  end

  def part_2 do
    read()
    |> Enum.filter(&valid_2/1)
    |> length()
  end
end
