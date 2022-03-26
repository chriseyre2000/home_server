defmodule HomeServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HomeServer.Router.child_spec(),
      HomeServer.Scheduler.child_spec(HomeServer.RepeatedPrint, %HomeServer.Scheduler{
        function: fn -> IO.puts("THIS IS A MESSAGE FROM A FUNCTION") end
      }),
      HomeServer.Scheduler.child_spec(HomeServer.NoOp, %HomeServer.Scheduler{
        interval_seconds: 1
      }),
    ]

    opts = [strategy: :one_for_one, name: HomeServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
