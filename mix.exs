defmodule HomeServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :home_server,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :telemetry],
      mod: {HomeServer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:httpoison, "1.8.0"},
      {:yaml_elixir, "~> 2.8"}
    ]
  end
end
