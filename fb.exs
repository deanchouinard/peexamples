fizzb = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c ->  c
end

IO.puts fizzb.(0,0,9)
IO.puts fizzb.(0,9,9)
IO.puts fizzb.(9,0,9)
IO.puts fizzb.(1,2,8)


IO.puts "========"

tfizz = fn
  n -> fizzb.(rem(n,3), rem(n,5), n)
end

IO.puts tfizz.(10)
IO.puts tfizz.(11)
IO.puts tfizz.(12)
IO.puts tfizz.(13)
IO.puts tfizz.(14)
IO.puts tfizz.(15)
IO.puts tfizz.(16)

IO.puts "==Functions-4=="

prefix = fn str1 -> (fn str2 -> "#{str1} #{str2}" end) end

first = prefix.("First")
IO.puts first.("second")
IO.puts prefix.("One").("Two")


