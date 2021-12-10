defmodule Day9 do
  
  def part1 do
    grid = input()

    grid
    |> Enum.filter(fn {coord, value} ->
        grid
          |> get_cross_values(coord)
          |> local_minima?(value)
        end)
    |> Enum.map(fn {_, x} -> x + 1 end)
    |> Enum.sum()
  end

  def part2 do
    grid =
      input()
      |> Enum.reject(fn {_, x} -> x == 9 end)
      |> Map.new()
    grid
  end

  def input() do
    "day9.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} -> 
        line
        |> String.graphemes()
        |> Enum.map(&String.to_integer/1)
        |> Enum.with_index()
        |> Enum.map(fn {n, x} -> {{x,y}, n} end)
      end)
    |> Map.new()
  end

  def local_minima?(cross, center), do: Enum.all?(cross, &(&1 > center))

  def get_cross(grid, {x, y}) do
    [{x-1, y}, {x+1, y}, {x, y-1}, {x, y+1}]
    |> Enum.map(fn coord -> {coord, Map.get(grid, coord)} end)
    |> Enum.reject(fn {_, value} -> is_nil(value) end)
  end

  def get_cross_values(grid, xy) do
    get_cross(grid, xy)
    |> Enum.map(fn {_, value} -> value end)
  end
end