defmodule MyList do

  def len([]), do: 0
  def len([_head|tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head|tail]), do: [head*head | square(tail)]

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def sum(list), do: _sum(list,0)
  defp _sum([], total), do: total
  defp _sum([head|tail], total), do: _sum(tail, head+total)

  def nsum([]), do: 0
  def nsum([head|tail] ), do: head + nsum(tail)

  def reduce([], value, _) do
    value
  end
  def reduce([head|tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def mapsum(list, func), do: _mapsum(list, func, 0)
  def _mapsum([], func, total), do: total
  def _mapsum([head|tail], func, total) do
    _mapsum(tail, func, total + func.(head))
  end

  def max(list), do: _max(list, 0)
  def _max([], value), do: value
  def _max([head|tail], value) when head > value do
    value = head
    _max(tail, value)
  end
  def _max([head|tail], value) when head < value do
    _max(tail, value)
  end

  def caesar([]), do: 0
  def caesar([head|tail]) do
    IO.puts(head)
    IO.puts([head])
    caesar(tail)
  end

end

