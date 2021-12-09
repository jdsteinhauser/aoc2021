defmodule Day7 do

  def part1 do
    xs = input()
    {min, max} = Enum.min_max(xs)
    min..max
    |> Enum.map(fn n -> 
        Enum.map(xs, fn x -> abs(n - x) end)
        |> Enum.sum() end)
    |> Enum.min()
  end

  def part2 do
    xs = input()
    {min, max} = Enum.min_max(xs)
    min..max
    |> Enum.map(fn n -> 
        Enum.map(xs, fn x -> Enum.sum(1..abs(n - x)) end)
        |> Enum.sum() end)
    |> Enum.min()
  end

  def input do
    "day7.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> hd()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end