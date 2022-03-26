defmodule HomeServerTest do
  use ExUnit.Case
  doctest HomeServer

  test "Can I call a website" do
    assert HomeServer.endpoint_alive?("https://www.bbc.co.uk/news")
  end

  defp random_name do
    for _ <- 1..100, into: "", do: <<Enum.random('0123456789abcdef')>>
  end

  test "Can I call a non-existant website" do
    refute HomeServer.endpoint_alive?("https://#{random_name()}")
  end
end
