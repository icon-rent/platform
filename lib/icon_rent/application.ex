defmodule IconRent.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      IconRentWeb.Telemetry,
      IconRent.Repo,
      {DNSCluster, query: Application.get_env(:icon_rent, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: IconRent.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: IconRent.Finch},
      # Start a worker by calling: IconRent.Worker.start_link(arg)
      # {IconRent.Worker, arg},
      # Start to serve requests, typically the last entry
      IconRentWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IconRent.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IconRentWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
