defmodule Incrementer.State do
  import Ecto.Query
  use GenServer

  def start_link(name \\ nil) do
    GenServer.start_link(__MODULE__, :ok, [name: name])
  end

  def increment(pid, key, value) do
    GenServer.call(pid, {:increment, key, value})
  end

  def sync(state) do
    Numbers.Repo.insert_all(
      Incrementer.Number,
      Enum.reduce(state, [], fn {key, value}, acc -> [%{key: key, value: value} | acc] end),
      on_conflict: :replace_all,
      conflict_target: :key)
  end

  def schedule_sync() do
    Process.send_after(self(), :sync, 10_000)
  end

  def init(:ok) do
    entries = Numbers.Repo.all(from n in Incrementer.Number, select: [n.key, n.value])
    state = Map.new(Enum.map(entries, fn [key, value] -> {key, value} end))
    schedule_sync()
    {:ok, state}
  end

  def handle_call({:increment, key, value}, _from, state) do
    {:reply, :ok, Map.update(state, key, value, &(&1 + value))}
  end

  def handle_info(:sync, state) do
    spawn(__MODULE__, :sync, [state])
    schedule_sync()
    {:noreply, state}
  end
end
