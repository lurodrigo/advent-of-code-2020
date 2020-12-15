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
    if pos == :array.size(input) do
      {acc, true}
    else
      case :array.get(pos, input) do
        {instruction, number, executed} ->
          if executed do
            {acc, false}
          else
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

        _ ->
          {nil, false}
      end
    end
  end

  def part_1 do
    read_input()
    |> interpret(0, 0)
  end

  def look_for_stop(input, pos) do
    if pos == :array.size(input) do
      -1
    else
      case :array.get(pos, input) do
        {"nop", number, _} ->
          IO.puts("changing pos #{pos}\n")

          case :array.set(pos, {"jmp", number, false}, input)
               |> interpret(0, 0)
               |> IO.inspect() do
            {_, false} -> look_for_stop(input, pos + 1)
            {acc, true} -> acc
          end

        {"jmp", number, _} ->
          IO.puts("changing pos #{pos}\n")

          case :array.set(pos, {"nop", number, false}, input)
               |> interpret(0, 0)
               |> IO.inspect() do
            {_, false} -> look_for_stop(input, pos + 1)
            {acc, true} -> acc
          end

        _ ->
          look_for_stop(input, pos + 1)
      end
    end
  end

  def part_2 do
    read_input()
    |> look_for_stop(0)
  end
end
