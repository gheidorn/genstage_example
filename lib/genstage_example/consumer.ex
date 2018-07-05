defmodule GenstageExample.Consumer do
  use GenStage

  #
  # client api
  #
  def start_link(pipeline_name) do
    process_name = Enum.join([pipeline_name, "Consumer"], "")
    GenStage.start_link(__MODULE__, pipeline_name, name: String.to_atom(process_name))
  end

  #
  # server callbacks
  #
  def init(pipeline_name) do
    {:consumer, pipeline_name,
     subscribe_to: [{GenstageExample.Producer, min_demand: 0, max_demand: 3}]}
  end

  def handle_events(events, _from, pipeline_name) do
    IO.puts("#{pipeline_name} Consumer received #{length(events)} events")

    for event <- events do
      # IO.inspect({self(), event})
      IO.puts(event["name"])
    end

    Process.sleep(30000)
    {:noreply, [], pipeline_name}
  end
end
