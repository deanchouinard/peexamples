defmodule Link1 do
  import :timer, only: [ sleep: 1 ]

  def sad_function do
    sleep 500
    exit(:boom)
  end
  def run do
  #    spawn(Link1, :sad_function, [])
    Process.flag(:trap_exit, true)
    spawn_link(Link1, :sad_function, [])
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVE: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happened"
    end
  end
end

Link1.run

