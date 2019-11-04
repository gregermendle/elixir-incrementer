defmodule IncrementerTest do
  use ExUnit.Case
  doctest Incrementer

  test "greets the world" do
    assert Incrementer.hello() == :world
  end
end
