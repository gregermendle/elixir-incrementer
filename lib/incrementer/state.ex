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

  def schedule_sync() do
    Process.send_after(self(), :sync, 10_000)
  end

  def sync() do
    entries = Enum.reduce(get_state(self), [], fn {key, value}, acc -> [%{key: key, value: value} | acc] end)
    {count, resp} = Numbers.Repo.insert_all(
      Incrementer.Number,
      entries,
      on_conflict: :replace_all,
      conflict_target: :key)
  end

  def init(state) do
    schedule_sync()
    {:ok, state}
  end

  def handle_call({:increment, key, value}, _from, state) do
    {:reply, :ok, Map.update(state, key, value, &(&1 + value))}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:sync, state) do
    schedule_sync()
    {:no_reply, state}
  end
end
