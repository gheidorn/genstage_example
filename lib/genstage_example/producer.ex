defmodule GenstageExample.Producer do
  use GenStage

  defstruct make: "", model: "", year: 0

  #
  # client api
  #
  def start_link(initial \\ 0) do
    GenStage.start_link(__MODULE__, initial, name: __MODULE__)
  end

  def load({_count, _events} = message) do
    IO.puts("casting events to producer")
    GenServer.cast(__MODULE__, {:events, message})
  end

  #
  # server callbacks
  #
  def init(0) do
    IO.puts("initialized #{__MODULE__}")
    {:producer, 0}
  end

  # def init(file) do
  #   # read the file and build a a list of structs
  #   lines =
  #     File.stream!(file)
  #     |> Stream.map(&String.replace(&1, "\n", ""))
  #     |> Stream.map(fn line -> String.split(line, "|", trim: false) end)
  #     |> Enum.to_list()

  #   # IO.puts(length(lines))

  #   {:producer, lines}
  # end

  def handle_demand(demand, state) when demand > 0 do
    # IO.puts("handle_demand: #{demand}")
    new_demand = demand + state
    {count, events} = take(new_demand)
    {:noreply, events, new_demand - count}
  end

  def handle_cast({:events, {count, events}}, state) do
    # IO.puts("producer got notified about #{count} new events")
    {:noreply, events, state - count}
  end

  defp take(demand) do
    # IO.puts("asking for #{demand} events")
    {count, events} = pull(demand)
    # IO.puts("received #{count} events")

    {count, events}
  end

  defp pull(demand) do
    events = Mtg.cards(page_size: 3)[:cards]
    {demand, events}
  end
end
