defmodule Day2 do

  def part1 do
    input()
    |> Enum.map(&parse_line/1)
    |> Enum.reduce({0,0}, fn {x1,y1}, {x,y} -> {x+x1, y+y1} end)
  end

  def part2 do
    input()
    |> Enum.map(&parse_line/1)
    |> Enum.reduce({0,0,0}, 
        fn {x,y}, {aim, pos, depth} -> {aim + y, pos + x, depth + (x * aim)} end)
  end
  
  def parse_line("forward " <> sx) do
    x = String.to_integer(sx)
    {x, 0}
  end
  
  def parse_line("down " <> sy) do
    y = String.to_integer(sy)
    {0, y}
  end
  
  def parse_line("up " <> sy) do
    y = String.to_integer(sy)
    {0, -y}
  end

  def input do
    "day2.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end