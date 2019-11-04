defmodule Incrementer.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Incrementer.Router.init([])

  test "it returns 500 on empty request body" do
    conn = conn(:post, "/increment")
    conn = Incrementer.Router.call(conn, @opts)
    assert conn.status == 500
  end

  test "it returns 500 on missing key" do
    conn = conn(:post, "/increment", %{value: "1"})
    conn = Incrementer.Router.call(conn, @opts)
    assert conn.status == 500
  end

  test "it returns 500 on missing value" do
    conn = conn(:post, "/increment", %{key: "derp"})
    conn = Incrementer.Router.call(conn, @opts)
    assert conn.status == 500
  end

  test "it returns 500 on value non-integer" do
    conn = conn(:post, "/increment", %{key: "derp", value: "non-int"})
    conn = Incrementer.Router.call(conn, @opts)
    assert conn.status == 500
  end

  test "it increments a key by a set value" do
    conn = conn(:post, "/increment", %{key: "test", value: "2"})
    conn = Incrementer.Router.call(conn, @opts)
    conn = conn(:post, "/increment", %{key: "test", value: "5"})
    conn = Incrementer.Router.call(conn, @opts)
    assert conn.status == 200
    assert Incrementer.State.get_state(Incrementer.State)["test"] == 7
  end
end
