defmodule CodeExample.Projections.RankingsProjector do
  @moduledoc """
  Rankings Projector.
  """

  use Commanded.Projections.Ecto,
    application: CodeExample.App,
    repo: CodeExample.Repo,
    name: __MODULE__,
    start_from: :origin

  alias CodeExample.Game.Events.{GameEnded}

  project(%GameEnded{}, _metadata, fn multi ->
    multi
  end)

  @impl Commanded.Event.Handler
  def error(_error, _failed_event, _failure_context) do
    :skip
  end
end