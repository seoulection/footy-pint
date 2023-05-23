defmodule FootyPint.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      FootyPintWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: FootyPint.PubSub},
      # Start Finch
      {Finch, name: FootyPint.Finch},
      # Start the Endpoint (http/https)
      FootyPintWeb.Endpoint
      # Start a worker by calling: FootyPint.Worker.start_link(arg)
      # {FootyPint.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FootyPint.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FootyPintWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
