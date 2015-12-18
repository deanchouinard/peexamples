defmodule Chop do
  def guess(n, [lower..upper]) do
    IO.puts "Answer: #{n}, #{lower}, #{upper}"
    make_guess(n, gen_guess(lower,upper), [lower..upper])
  end

  def make_guess(answer, the_guess, [lower..upper]) when the_guess == answer do
    IO.puts "Correct: #{the_guess}"
  end
  def make_guess(answer, the_guess, [lower..upper]) when the_guess < answer do
    IO.puts "LT Guess: #{the_guess}, #{lower}, #{upper}"
    lower = the_guess+1
    make_guess(answer, gen_guess(lower,upper), [lower..upper])
  end
  def make_guess(answer, the_guess, [lower..upper]) when the_guess > answer do
    IO.puts "GT Guess: #{the_guess}"
    upper = the_guess-1
    make_guess(answer, gen_guess(lower, upper), [lower..upper])
  end
  def gen_guess(lower, upper) do
    lower + div(upper-lower,2)
  end
end
