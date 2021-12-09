defmodule Day8 do
  
  def part1 do
    input()
    |> Enum.flat_map(&(&1[:output]))
    |> Enum.count(fn x -> Enum.member?([2,4,3,7], String.length(x)) end)
  end

  def part2 do
    input()
    |> Enum.map(&solve/1)
    |> Enum.sum()    
  end

  def input() do
    "day8.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&format_line/1)
  end

  def format_line(line) do
    [input, output] =
      line
      |> String.split([" ", "|"], trim: true)
      |> Enum.chunk_every(10)
    %{input: input, output: output}
  end

  def solve(%{input: input, output: output}) do
    %{
      2 => [one],
      3 => [seven],
      4 => [four],
      7 => [eight],
      5 => two_three_five,
      6 => zero_six_nine
    } = 
      input |> Enum.map(&to_charlist/1) |> Enum.group_by(&Enum.count/1)

    [a | _] = seven -- one
    three = Enum.find(two_three_five, fn x -> Enum.count(x -- one) == 3 end)
    five = Enum.find(two_three_five -- [three], fn x -> Enum.count(x -- four) == 2 end)
    [two | _] = two_three_five -- [three, five]
    [g | _] = (five -- four) -- [a]
    nine = Enum.find(zero_six_nine, fn x -> (x -- [a,g]) -- four == [] end)
    [e | _] = eight -- nine
    six = Enum.find(zero_six_nine, fn x -> Enum.empty?(x -- (five ++ [e])) end)
    [zero | _] = zero_six_nine -- [six, nine]

    map = 
      [zero, one, two, three, four, five, six, seven, eight, nine]
      |> Enum.map(&Enum.sort/1)
      |> Enum.zip(0..9)
      |> Map.new()

    output
    |> Enum.map(&to_charlist/1)
    |> Enum.map(&Enum.sort/1)
    |> Enum.map(&(map[&1]))
    |> Integer.undigits()
  end

end