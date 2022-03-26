defmodule HomeServerTest do
  use ExUnit.Case
  doctest HomeServer

  test "greets the world" do
    assert HomeServer.hello() == :world
  end
end
