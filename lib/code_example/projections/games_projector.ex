defmodule CodeExample.Projections.GamesProjector do
  @moduledoc """
  Games Projector.
  """

  use Commanded.Projections.Ecto,
    application: CodeExample.App,
    repo: CodeExample.Repo,
    name: __MODULE__,
    start_from: :origin

  alias CodeExample.Game.Events.{GameCreated, GameEnded, NumberGuessed}

  project(%GameCreated{}, _metadata, fn multi ->
    multi
  end)

  project(%GameEnded{}, _metadata, fn multi ->
    multi
  end)

  project(%NumberGuessed{}, _metadata, fn multi ->
    multi
  end)

  @impl Commanded.Event.Handler
  def error(_error, _failed_event, _failure_context) do
    :skip
  end
end