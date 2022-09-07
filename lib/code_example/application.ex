defmodule CodeExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl Application
  def start(_type, _args) do
    children = [
      # Start the Commanded application
      CodeExample.App,

      # Start the Ecto Repo
      CodeExample.Repo,

      # Start process managers
      {CodeExample.Processes.NotifyPlayers, hibernate_after: :timer.seconds(15)},

      # Start read model projectors
      {CodeExample.Projections.GamesProjector, hibernate_after: :timer.seconds(15)},
      {CodeExample.Projections.RankingsProjector, hibernate_after: :timer.seconds(15)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CodeExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end