defmodule HomeServer.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # The web endpoints
      HomeServer.Router.child_spec(),
      # Checks that has internet connection
      HomeServer.Scheduler.child_spec(HomeServer.NetworkUp, %HomeServer.Scheduler{
        name: HomeServer.NetworkUp,
        interval_seconds: 10,
        function: &HomeServer.Checks.network_up/0
      }),
      # DynamicSupervisor: allows other tasks to be added.
      {DynamicSupervisor, strategy: :one_for_one, name: HomeServer.DynamicSupervisor},
      HomeServer.Configurator
    ]

    opts = [strategy: :one_for_one, name: HomeServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
