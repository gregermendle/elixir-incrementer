defmodule Incrementer do
  use Application

  def start(_type, _args) do
    Incrementer.Supervisor.start_link(name: Incrementer.Supervisor)
  end
end
