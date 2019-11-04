defmodule Incrementer.SQLiteSync do
  use Task

  def start_link(_opts) do
    Task.start_link(&sync/0)
  end

  def sync() do
    receive do
    after 10_000 ->
      IO.inspect Incrementer.State.get_state(Incrementer.State)
      sync()
    end
  end
end