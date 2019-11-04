defmodule Incrementer.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      worker(Incrementer.State, [Incrementer.State]),
      Numbers.Repo,
      Incrementer.SQLiteSync,
      Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: Incrementer.Router, options: [port: 3333])
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end