defmodule Incrementer.State do
  use GenServer

  def start_link(name \\ nil) do
    GenServer.start_link(__MODULE__, %{}, [name: name])
  end

  def increment(pid, key, value) do
    GenServer.call(pid, {:increment, key, value})
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:increment, key, value}, _from, state) do
    {:reply, :ok, Map.update(state, key, value, &(&1 + value))}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
end
