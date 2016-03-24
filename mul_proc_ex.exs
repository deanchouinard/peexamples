defmodule Link1 do
  import :timer, only: [ sleep: 1 ]

  def sad_function(parent) do
  #    sleep 500
    send(parent, "hello")
        exit(:boom)
  end

  def rec_lo do

    receive do
      msg ->
        IO.puts "MESSAGE RECEIVE: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happened"
    end

    rec_lo
  end

  def run do
  #    spawn(Link1, :sad_function, [])
  #    Process.flag(:trap_exit, true)
  # spawn_link(Link1, :sad_function, [self])
    spawn_monitor(Link1, :sad_function, [self])
    sleep 500
    rec_lo
  end
end

Link1.run

