defmodule Day6 do

  def part1 do
    input()
    |> Stream.iterate(&big_tick/1)
    |> Enum.at(80)
    |> Enum.count()
  end

  def part1_5 do
    init = Enum.frequencies(input())

    1..79
    |> Enum.reduce(init, fn n, xs -> mapped(n, xs) end)
    |> Map.values()
    |> Enum.sum()
  end

  def part2 do
    init = Enum.frequencies(input())

    1..255
    |> Enum.reduce(init, fn n, xs -> mapped(n, xs) end)
    |> Map.values()
    |> Enum.sum()
  end

  def input do 
    "day6.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> hd()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def big_tick(xs), do: Enum.flat_map(xs, &tick/1)

  def tick(0), do: [6,8]
  def tick(x), do: [x-1]

  def mapped(iter, xs) do
    {spawns, remaining} = Map.pop(xs, iter, 0)
    remaining
    |> Map.update(iter + 7, spawns, &(&1 + spawns))
    |> Map.update(iter + 9, spawns, &(&1 + spawns))
  end
end