defmodule FibSolver do

  def fib(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:fib, n, client} ->
        send client, {:answer, n, fib_calc(n), self}
        fib(scheduler)
      {:shutdown} -> exit(:normal)
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n-1) + fib_calc(n-2)
end

defmodule CatCounter do
  def count_cats(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:count_cats, fd, client} ->
    IO.puts "cat counter receive"
        send client, {:answer, fd, cnt_cats(fd), self}
        count_cats(scheduler)
      {:shutdown} -> exit(:normal)
    end
  end

  defp cnt_cats(file_name) do
    matches = Regex.scan(~r/cat/, File.read!(file_name))
    { length(matches) }
  end
end


defmodule Scheduler do
  def run(module, func, to_calculate) do
    (1..length(to_calculate))
    |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        IO.puts "sched receive"
        [next | tail] = queue
        send pid, {:count_cats, next, self}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
          #          IO.inspect(results)
        end
      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [ {number, result} | results ])
    end
  end
end


file_list = File.ls!("cfiles")
file_list = Enum.map file_list, fn file -> "cfiles/" <> file end

result = Scheduler.run(CatCounter, :count_cats, file_list)
IO.inspect(result)
total = Enum.reduce(result, 0, fn {item, {cnt}} = fd, tot -> 
  IO.puts "File: #{item} Count: #{cnt}"
  tot = tot + cnt
  end)

IO.puts "Total: #{total}"



# to_process = [37, 37, 37, 37, 37, 37 ]
# Enum.each 1..10, fn num_processes ->
#   {time, result} = :timer.tc(
#   Scheduler, :run,
#   [num_processes, FibSolver, :fib, to_process]
#   )
#
#   if num_processes == 1 do
#     IO.puts inspect result
#     IO.puts "\n #   time (s)"
#   end
#   :io.format "~2B       ~.2f~n", [num_processes, time/1000000.0]
# end
#
