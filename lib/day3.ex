use Bitwise

defmodule Day3 do

  def part1 do
    ones =
      input()
      |> Enum.map(&Kernel.to_charlist/1)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&most_common/1)
      |> Integer.undigits(2)

    zeroes = Bitwise.bxor(ones, 0xfff)

    {ones, zeroes, ones * zeroes}
  end

  def part2 do
    xs = Enum.map(input(), fn x -> String.to_integer(x, 2) end)
    ones = 
      11..0
      |> Enum.reduce(xs, fn n, acc -> filter_max(acc, n) end)
      |> hd()

    zeroes = 
      11..0
      |> Enum.reduce(xs, fn n, acc -> filter_min(acc, n) end)
      |> hd()

    { ones, zeroes, ones * zeroes }
  end

  def input do
    "day3.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def most_common(xs) do
    length = Enum.count(xs)
    ones = Enum.count(xs, fn x -> x == ?1 end)
    if ones > length / 2, do: 1, else: 0
  end

  def filter_max(xs, msb) do
    halfway = Enum.count(xs) / 2
    mask = 1 <<< msb
    {ones, zeroes} = Enum.split_with(xs, fn x -> Bitwise.band(x, mask) == mask end)
    
    cond do
      Enum.count(ones) == 0 -> zeroes
      Enum.count(zeroes) == 0 -> ones
      Enum.count(ones) >= halfway -> ones
      true -> zeroes
    end
  end
  
  def filter_min(xs, msb) do
    halfway = Enum.count(xs) / 2
    mask = 1 <<< msb
    {ones, zeroes} = Enum.split_with(xs, fn x -> Bitwise.band(x, mask) == mask end)

    cond do
      Enum.count(ones) == 0 -> zeroes
      Enum.count(zeroes) == 0 -> ones
      Enum.count(ones) >= halfway -> zeroes
      true -> ones
    end
  end  
end