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
end

