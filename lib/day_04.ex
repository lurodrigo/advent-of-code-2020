defmodule Day4 do
  def read_input() do
    File.read!("input/day_04.txt")
    |> String.split("\n")
    |> Enum.chunk_by(fn line -> line == "" end)
    |> Enum.reject(fn chunk -> chunk == [""] end)
    |> Enum.map(fn chunk ->
      chunk
      |> Enum.flat_map(&String.split/1)
      |> to_map()
    end)
  end

  def to_map(data) do
    data
    |> Enum.map(fn raw_data ->
      raw_data
      |> String.split(":")
      |> List.to_tuple()
    end)
    |> Enum.into(%{})
  end

  def has_required_fields?(data) do
    ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    |> Enum.map(fn field -> Map.has_key?(data, field) end)
    |> Enum.all?()
  end

  def part_1() do
    read_input()
    |> Enum.filter(&has_required_fields?/1)
    |> length()
  end

  def validate(field, value) do
    case field do
      "byr" ->
        case Integer.parse(value) do
          {num, ""} -> num >= 1920 and num <= 2002
          _ -> false
        end

      "iyr" ->
        case Integer.parse(value) do
          {num, ""} -> num >= 2010 and num <= 2020
          _ -> false
        end

      "eyr" ->
        case Integer.parse(value) do
          {num, ""} -> num >= 2020 and num <= 2030
          _ -> false
        end

      "hgt" ->
        case Integer.parse(value) do
          {num, "cm"} -> num >= 150 and num <= 193
          {num, "in"} -> num >= 59 and num <= 76
          _ -> false
        end

      "hcl" ->
        Regex.run(~r/^#[0-9a-f]{6}$/, value)

      "ecl" ->
        Enum.member?(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], value)

      "pid" ->
        Regex.run(~r/^\d{9}$/, value)

      "cid" ->
        true
    end
  end

  def part_2() do
    read_input()
    |> Enum.filter(fn data ->
      has_required_fields?(data) and
        data
        |> Enum.map(fn {field, value} -> validate(field, value) end)
        |> Enum.all?()
    end)
    |> length()
  end
end
