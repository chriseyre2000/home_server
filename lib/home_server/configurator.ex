defmodule HomeServer.Configurator do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(args) do
    filename = "#{System.user_home()}/.home-server"

    if File.exists?(filename) do
      # This is dumb, I need a better file format
      [url, time, title, message] = File.read!(filename) |> String.split("|")

      {time_in_seconds, _} = Integer.parse(time)

      DynamicSupervisor.start_child(
        HomeServer.DynamicSupervisor,
        HomeServer.Scheduler.child_spec(:"#{url}", %HomeServer.Scheduler{
          interval_seconds: time_in_seconds,
          function: fn ->
            unless HomeServer.endpoint_alive?(url) do
              HomeServer.desktop_notification(title, message)
            end
          end
        })
      )
    end

    {:ok, args}
  end
end
