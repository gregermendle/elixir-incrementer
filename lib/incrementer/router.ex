defmodule Incrementer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug Plug.Parsers, parsers: [:multipart]
  plug Plug.Logger, log: :debug
  plug :match
  plug :dispatch

  post "/increment" do
    case conn.params do
      %{"key" => key, "value" => value} -> 
        case Integer.parse(value) do
          {parsed, ""} -> 
            Incrementer.State.increment(Incrementer.State, key, parsed)
            send_resp(conn, 200, "")
          _ -> send_resp(conn, 500, "Value must be an integer!")
        end        
      _ -> 
        send_resp(conn, 500, "Invalid input!")
    end
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end