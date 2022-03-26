defmodule HomeServer.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # The web endpoints
      HomeServer.Router.child_spec(),
      # Checks that has internet connection
      HomeServer.Scheduler.child_spec(HomeServer.NoOp, %HomeServer.Scheduler{
        interval_seconds: 10,
        function: &HomeServer.Checks.network_up/0
      }),
      #DynamicSupervisor: allows other tasks to be added.
      {DynamicSupervisor, strategy: :one_for_one, name: HomeServer.DynamicSupervisor}
    ]

    opts = [strategy: :one_for_one, name: HomeServer.Supervisor]
    res = Supervisor.start_link(children, opts)

    Task.start(fn ->
      Process.sleep(5_000)
      #This will check for a ~/.home-server file and parse it
      HomeServer.Configurator.init()
    end)

    res
  end
end
