defmodule Incrementer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug Plug.Parsers, parsers: [:urlencoded]
  plug Plug.Logger, log: :debug
  plug :match
  plug :dispatch

  post "/increment" do
    case conn.params do
      %{"key" => key, "value" => value} -> 
        Incrementer.State.increment(Incrementer.State, key, String.to_integer(value))
        send_resp(conn, 200, "")
      _ -> 
        send_resp(conn, 500, "Invalid input!")
    end
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end