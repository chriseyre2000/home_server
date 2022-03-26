defmodule HomeServer do
  @moduledoc """
  Documentation for `HomeServer`.
  """

  def endpoint_alive?(url) do
    {status, _body} = HTTPoison.get(url)
    status == :ok
  end

  def desktop_notification(title, message) do
    System.cmd("terminal-notifier", ["-message", message, "-title", title])
  end
end
