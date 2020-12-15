defmodule Day7 do
  def read_input() do
    File.read!("input/day_07.txt")
    |> String.split("\n")
    |> Enum.map(&parse_input/1)
    |> Enum.into(%{})
  end

  def parse_input(input) do
    [_, obj, rest] = Regex.run(~r/([\S ]+) bags contain (.*)/, input)

    {obj,
     rest
     |> case do
       "no other bags." ->
         %{}

       rest ->
         rest
         |> String.split([", ", "\."])
         |> Enum.flat_map(fn
           "" ->
             []

           bag_info ->
             [_, count, color] = Regex.run(~r/(\d+) ([\S ]+) bags?/, bag_info)
             [{color, :erlang.binary_to_integer(count)}]
         end)
         |> Enum.into(%{})
     end}
  end

  @spec dfs(map, any) :: [any]
  def dfs(graph, node) do
    directly = Map.get(graph, node, [])
    Enum.concat([directly | Enum.map(directly, &dfs(graph, &1))])
  end

  def graph() do
    read_input()
    |> Enum.flat_map(fn
      {_, []} ->
        []

      {sup, subs} ->
        subs
        |> Map.keys()
        |> Enum.map(fn key -> {key, sup} end)
    end)
    |> Enum.group_by(fn {key, _} -> key end)
    |> Enum.map(fn {key, l} ->
      {key,
       l
       |> Enum.map(fn {_, value} -> value end)}
    end)
    |> Enum.into(%{})
  end

  def part_1 do
    graph()
    |> dfs("shiny gold")
    |> Enum.uniq()
    |> length()
  end

  def rec(input, node) do
    directly = Map.get(input, node, %{})

    directly
    |> Enum.map(fn {key, value} ->
      value * (rec(input, key) + 1)
    end)
    |> Enum.sum()
  end

  def part_2 do
    read_input()
    |> rec("shiny gold")
  end
end
