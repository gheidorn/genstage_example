defmodule GenstageExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: GenstageExample.Worker.start_link(arg)
      # {GenstageExample.Worker, arg},

      # worker(GenstageExample.Producer, ['/Users/gregheidorn/Downloads/inventory502.txt']),
      worker(GenstageExample.Producer, []),
      # worker(GenstageExample.ProducerConsumer, []),
      worker(GenstageExample.Consumer, ["Pipeline1"], id: 1),
      worker(GenstageExample.Consumer, ["Pipeline2"], id: 2)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GenstageExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
