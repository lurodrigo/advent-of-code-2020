defmodule Day8 do
  def read_input() do
    File.read!("input/day_08.txt")
    |> String.split("\n")
    |> Enum.map(&parse_input/1)
    |> :array.from_list()
  end

  def parse_input(line) do
    [_, instruction, number] = Regex.run(~r/(acc|jmp|nop) ([+-]\d+)/, line)
    {instruction, :erlang.binary_to_integer(number), false}
  end

  def interpret(input, acc, pos) do
    {instruction, number, executed} = :array.get(pos, input)

    cond do
      executed ->
        {acc, false}

      pos == :array.size(input) ->
        {acc, true}

      true ->
        updated = :array.set(pos, {instruction, number, true}, input)

        case instruction do
          "acc" ->
            interpret(updated, acc + number, pos + 1)

          "nop" ->
            interpret(updated, acc, pos + 1)

          "jmp" ->
            interpret(updated, acc, pos + number)
        end
    end
  end

  def part_1 do
    read_input()
    |> interpret(0, 0)
  end

  def part_2 do
  end
end
