defmodule HomeServer.Scheduler do
  use GenServer

  defstruct interval_seconds: 5, function: &__MODULE__.empty/0, name: :nil

  def child_spec(id, args = %__MODULE__{}) do
    %{
      id: id,
      start: {
        HomeServer.Scheduler,
        :start_link,
        [
          [
            args
          ]
        ]
      }
    }
  end

  def init([%__MODULE__{} = args]) do
    schedule_work(args.interval_seconds)
    {:ok, args}
  end

  def handle_info(:work, state) do
    # Do the desired work here
    # ...
    state.function.()

    # Reschedule once more
    schedule_work(state.interval_seconds)

    {:noreply, state}
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: args |> hd() |> Map.get(:name))
  end

  defp schedule_work(interval) do
    # We shedule the work to happen after this defined time.
    Process.send_after(self(), :work, interval * 1000)
  end

  def empty, do: :noop
end
