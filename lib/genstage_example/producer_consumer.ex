defmodule GenstageExample.ProducerConsumer do
  use GenStage

  require Integer

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [GenstageExample.Producer]}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      # IO.inspect({self(), event, state})
      IO.inspect({self(), Enum.at(event, 3)})
    end

    # numbers =
    #   events
    #   |> Enum.filter(&Integer.is_even/1)

    {:noreply, [], state}
  end
end
