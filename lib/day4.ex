defmodule Day4 do

  def part1 do
    %{called: called, boards: boards} = input()
    
    called
    |> Enum.reduce(%{winners: [], boards: boards}, &reducer/2)
    |> Map.get(:winners)
    |> Enum.reverse()
    |> hd()
    |> compute_answer()
  end

  def part2 do
    %{called: called, boards: boards} = input()

    called
    |> Enum.reduce(%{winners: [], boards: boards}, &reducer/2)
    |> Map.get(:winners)
    |> hd()
    |> compute_answer()
  end

  def reducer(n, %{winners: ws, boards: bs}) do
    new_bs = Enum.map(bs, fn b -> call_number(n, b) end)
    new_ws = 
      new_bs
      |> Enum.filter(&Day4.check_board/1)
    %{
      winners: Enum.map(new_ws, fn b -> %{number: n, board: b} end) ++ ws,
      boards: new_bs -- new_ws
    }
  end

  def compute_answer(%{number: n, board: b}) do
    b
    |> Enum.filter(fn {_k, {_r, _c, v}} -> not v end)
    |> Enum.map(fn {v, _} -> v end)
    |> Enum.sum()
    |> Kernel.*(n)
  end

  def call_number(x, board) do
    if Map.has_key?(board, x)
    do
      Map.update(board, x, true, fn {r, c, _} -> {r, c, true} end)
    else
      board
    end
  end

  def check_board(board), do: check_columns(board) or check_rows(board)

  def check_columns(board) do
    board
    |> Map.values()
    |> Enum.filter(fn {_r, _c, marked} -> marked end)
    |> Enum.frequencies_by(fn {_r, c, _} -> c end)
    |> Enum.any?(fn {_c, x} -> x == 5 end)
  end

  def check_rows(board) do
    board
    |> Map.values()
    |> Enum.filter(fn {_r, _c, marked} -> marked end)
    |> Enum.frequencies_by(fn {r, _c, _} -> r end)
    |> Enum.any?(fn {_r, x} -> x == 5 end)
  end

  def input do
    lines = 
      "day4.txt"
      |> File.read!()
      |> String.split("\n", trim: true)
    
    called = 
      lines
      |> hd()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    
    boards = 
      lines
      |> tl()
      |> Enum.chunk_every(5)
      |> Enum.map(&format_board/1)

    %{called: called, boards: boards}
  end

  def format_board(rows) do
    rows
    |> Enum.with_index()
    |> Enum.map(&format_row/1)
    |> Enum.reduce(&Map.merge/2)
  end

  def format_row({row, number}) do
    row
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Map.new(fn {x, column} -> {x, {rem(number, 5), column, false}} end)
  end

end