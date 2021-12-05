defmodule Day5 do

  def part1 do
    input()
    |> Enum.flat_map(&make_line/1)
    |> Enum.frequencies()
    |> Enum.count(fn {_k, v} -> v > 1 end)
  end

  def part2 do
    input()
    |> Enum.flat_map(&make_line2/1)
    |> Enum.frequencies()
    |> Enum.count(fn {_k, v} -> v > 1 end)
  end

  def input do 
    "day5.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&read_line/1)
  end

  def read_line(line) do
    line
    |> String.split([",", " -> "], trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def make_line([x, y, x, y]), do: [{x,y}]
  def make_line([x, y0, x, y1]), do: Enum.map(y0..y1, fn y -> {x, y} end)
  def make_line([x0, y, x1, y]), do: Enum.map(x0..x1, fn x -> {x, y} end)
  def make_line([_,_,_,_]), do: []

  def make_line2([x, y, x, y]), do: [{x,y}]
  def make_line2([x, y0, x, y1]), do: Enum.map(y0..y1, fn y -> {x, y} end)
  def make_line2([x0, y, x1, y]), do: Enum.map(x0..x1, fn x -> {x, y} end)
  def make_line2([x0, y0, x1, y1]), do: Enum.zip(x0..x1, y0..y1)

  def draw_board(points) do
    {x_min, x_max} =
      points
      |> Enum.map(fn x -> elem(x, 0) end)
      |> Enum.min_max()
    {y_min, y_max} =
      points
      |> Enum.map(fn y -> elem(y, 1) end)
      |> Enum.min_max()
    for y <- y_min..y_max, x <- x_min..x_max do
      case Enum.count(points, fn p -> p == {x,y} end) do
        0 -> ?.
        1 -> ?1
        _ -> ?X
      end
    end
    |> Enum.chunk_every(x_max - x_min + 1)
    |> Enum.map(&to_string/1)
    |> Enum.join("\n")
    |> IO.puts()
  end
end