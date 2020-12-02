defmodule Day1 do
  def find_sum_2(num_list, sum) do
    frequencies = Enum.frequencies(num_list)

    with [elem | _] <-
           (for({n, _} <- frequencies) do
              case Map.get(frequencies, sum - n) do
                nil ->
                  nil

                1 ->
                  if n == sum - n do
                    nil
                  else
                    n
                  end

                _ ->
                  n
              end
            end)
           |> Enum.reject(&is_nil/1) do
      elem * (sum - elem)
    else
      [] -> nil
    end
  end

  def find_sum_3(num_list) do
    for n <- num_list do
      case find_sum_2(List.delete(num_list, n), 2020 - n) do
        nil -> nil
        prod -> n * prod
      end
    end
    |> Enum.reject(&is_nil/1)
    |> Enum.at(0)
  end

  def read do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(&:erlang.binary_to_integer/1)
  end

  def part_1 do
    read()
    |> find_sum_2(2020)
  end

  def part_2 do
    read()
    |> find_sum_3()
  end
end
