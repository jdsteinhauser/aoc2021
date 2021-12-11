defmodule Day10 do

  @pairs %{
    ?{ => ?},
    ?< => ?>,
    ?( => ?),
    ?[ => ?]
  }

  @points1 %{
    ?) => 3,
    ?] => 57,
    ?} => 1197,
    ?> => 25137
  }

  @points2 %{
    ?) => 1,
    ?] => 2,
    ?} => 3,
    ?> => 4
  }

  def part1 do
    input()
    |> Enum.map(&chunk/1)
    |> Enum.filter(fn x -> is_tuple(x) && elem(x, 0) == :error end)
    |> Enum.map(fn x -> Map.get(@points1, elem(x, 1)) end)
    |> Enum.sum()
  end

  def part2 do
    input()
    |> Enum.map(&chunk/1)
    |> Enum.filter(fn x -> is_tuple(x) && elem(x, 0) == :incomplete end)
    |> Enum.map(fn {_, xs} -> 
        xs
        |> Enum.map(&Map.get(@points2, &1))
        |> Enum.reduce(0, fn x, acc -> acc * 5 + x end)
      end)
    |> Enum.sort()
    |> (fn xs -> 
        mid =
          xs
          |> Enum.count()
          |> Integer.floor_div(2)
        Enum.at(xs, mid)
      end).()
  end

  def input do
    "day10.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&to_charlist/1)
  end

  def chunk(chars), do: chunk([], chars)

  def chunk([], ''), do: :ok
  
  def chunk(remaining, '') when is_list(remaining) do
    {:incomplete, Enum.map(remaining, &(Map.get(@pairs, &1)))}
  end

  def chunk([], [next | chars]), do: chunk([next], chars)
  
  def chunk([top | stack], [next | chars]) do
    cond do
      Map.get(@pairs, top) == next -> chunk(stack, chars)
      Enum.member?([?}, ?], ?), ?>], next) -> {:error, next}
      true -> chunk([next, top | stack], chars)
    end
  end
end