defmodule HomeServer do
  @moduledoc """
  Documentation for `HomeServer`.
  """

  def endpoint_alive?(url) do
    HTTPoison.get(url)
    |> case do
       {:ok, _} -> true
       {:error, _} -> false
    end
  end
end
