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

  project(%GameCreated{
    game_id: game_id,
  }, _metadata, fn multi ->
    multi
    |> Ecto.Multi.insert(:games,
      %CodeExample.Projections.Games{
        game_id: game_id,
        guesses: [],
        started: false
      }
    )
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
