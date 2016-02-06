defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, { :ok, "Hello, #{msg}" }
        greet
    end
  end
end

pid1 = spawn(Spawn1, :greet, [])
pid2 = spawn(Spawn1, :greet, [])

send pid1, {self, "fred"}
send pid2, {self, "betty"}

receive do
  {:ok, message} ->
    IO.puts message
end

receive do
  {:ok, message} ->
    IO.puts message
end
