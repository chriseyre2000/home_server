defmodule HomeServer.Configurator do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(args) do
    process_file()
    {:ok, args}
  end

  defp process_file do
    filename = "#{System.user_home()}/.home-server.yml"

    if File.exists?(filename) do
      YamlElixir.read_all_from_file!(filename)
      |> hd()
      |> configure_tasks()
    end
  end

  defp configure_tasks(data) do
    for {k, v} <- data, do: configure_single_task(k, v)
  end

  defp configure_single_task(task_name, task_details) do

    interval_seconds = task_details |> Map.get("interval_seconds")
    url = task_details |> Map.get("test_url")
    title = task_details |> Map.get("title")
    message = task_details |> Map.get("message")

    DynamicSupervisor.start_child(
      HomeServer.DynamicSupervisor,
      HomeServer.Scheduler.child_spec(:"#{task_name}", %HomeServer.Scheduler{
        name: :"#{task_name}",
        interval_seconds: interval_seconds,
        function: fn ->
          unless HomeServer.endpoint_alive?(url) do
            HomeServer.desktop_notification(title, message)
          end
        end
      })
    )
  end
end
