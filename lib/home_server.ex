defmodule HomeServer do
  @moduledoc """
  Documentation for `HomeServer`.
  """

  def endpoint_alive?(url) do
    {status, _body} = HTTPoison.get(url)
    status == :ok
  end
end
