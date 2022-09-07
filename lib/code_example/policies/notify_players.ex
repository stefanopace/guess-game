defmodule CodeExample.Policies.NotifyPlayers do
  @moduledoc """
  NotifyPlayers.
  """

  use Commanded.Event.Handler,
    application: CodeExample.App,
    name: __MODULE__,
    start_from: :current

  alias CodeExample.Game.Events.{GameEnded, NumberGuessed, PlayerJoined}
  alias __MODULE__

  @impl Commanded.Event.Handler
  def handle(%GameEnded{}, _metadata) do
    :ok
  end

  @impl Commanded.Event.Handler
  def handle(%NumberGuessed{}, _metadata) do
    :ok
  end

  @impl Commanded.Event.Handler
  def handle(%PlayerJoined{}, _metadata) do
    :ok
  end

  @impl Commanded.Event.Handler
  def error(_error, _failure_source, _failure_context) do
    :skip
  end
end
