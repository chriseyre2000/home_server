defmodule HomeServer.Checks do
  def network_up do
    unless HomeServer.endpoint_alive?("https://www.bbc.co.uk/news") do
      HomeServer.desktop_notification("Network is down", "Check Router")
    end
  end
end
