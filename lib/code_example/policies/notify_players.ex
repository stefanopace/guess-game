defmodule CodeExample.Policies.NotifyPlayers do
  @moduledoc """
  NotifyPlayers.
  """

  use Commanded.Event.Handler,
    application: CodeExample.App,
    name: __MODULE__,
    start_from: :current

  alias CodeExample.Game.Events.{GameEnded, NumberGuessed, PlayerJoined}

  @impl Commanded.Event.Handler
  def handle(%GameEnded{}, _metadata) do
    :ok
  end

  @impl Commanded.Event.Handler
  def handle(%NumberGuessed{outcome: outcome, player_name: player_name}, _metadata) do
    IO.puts "Message for #{player_name}: #{outcome}!"
    :ok
  end

  @impl Commanded.Event.Handler
  def handle(%PlayerJoined{player1: player1}, _metadata) do
    IO.puts "Message for #{player1}: player2 joined!"
    :ok
  end

  @impl Commanded.Event.Handler
  def error(_error, _failure_source, _failure_context) do
    :skip
  end
end
