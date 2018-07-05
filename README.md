# GenstageExample

This example has a Producer and a Consumer. The Producer has a `pull/0` function that makes a call to the [mtg_sdk_ex](https://hex.pm/packages/mtg_sdk_ex) library to get some card data. The Consumer asks for between 0 and 3 events (`max_demand = 3`) and dumps the card name into an `IO.puts` statement.

_TODO_

- Tests for the Producer and the Consumer
- Inject a ProducerConsumer
- Do something interesting with the Card data

## To Run

`iex -S mix`
