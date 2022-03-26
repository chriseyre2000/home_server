defmodule HomeServer.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HomeServer.Router.child_spec(),
      # HomeServer.Scheduler.child_spec(HomeServer.RepeatedPrint, %HomeServer.Scheduler{
      #   function: fn -> IO.puts("THIS IS A MESSAGE FROM A FUNCTION") end
      # }),
      HomeServer.Scheduler.child_spec(HomeServer.NoOp, %HomeServer.Scheduler{
        interval_seconds: 10,
        function: &HomeServer.Checks.network_up/0
      }),
      {DynamicSupervisor, strategy: :one_for_one, name: HomeServer.DynamicSupervisor}
    ]

    opts = [strategy: :one_for_one, name: HomeServer.Supervisor]
    res = Supervisor.start_link(children, opts)

    Task.start(fn ->
      Process.sleep(5_000)
      HomeServer.Configurator.init()
    end)

    res
  end
end
