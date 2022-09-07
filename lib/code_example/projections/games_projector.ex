defmodule CodeExample.Projections.GamesProjector do
  @moduledoc """
  Games Projector.
  """

  use Commanded.Projections.Ecto,
    application: CodeExample.App,
    repo: CodeExample.Repo,
    name: __MODULE__,
    start_from: :origin

  alias CodeExample.Game.Events.{GameCreated, GameEnded, NumberGuessed, PlayerJoined}

  project(
    %GameCreated{
      game_id: game_id
    },
    _metadata,
    fn multi ->
      multi
      |> Ecto.Multi.insert(
        :games,
        %CodeExample.Projections.Games{
          game_id: game_id,
          guesses: [],
          started: false
        }
      )
    end
  )

  project(%PlayerJoined{game_id: game_id}, _metadata, fn multi ->
    multi
    |> Ecto.Multi.run(:game_to_update, fn _repo, _changes ->
      {:ok, CodeExample.Repo.get(CodeExample.Projections.Games, game_id)}
    end)
    |> Ecto.Multi.update(:games, fn %{game_to_update: game} ->
      Ecto.Changeset.change(game, started: true)
    end)
  end)

  project(%GameEnded{}, _metadata, fn multi ->
    multi
  end)

  project(
    %NumberGuessed{game_id: game_id, number: number, outcome: outcome},
    _metadata,
    fn multi ->
      multi
      |> Ecto.Multi.run(:game_to_update, fn _repo, _changes ->
        {:ok, CodeExample.Repo.get(CodeExample.Projections.Games, game_id)}
      end)
      |> Ecto.Multi.update(:games, fn %{game_to_update: game} ->
        new_guesses = [
          %{
            number: number,
            outcome: outcome
          }
          | game.guesses
        ]

        Ecto.Changeset.change(game, guesses: new_guesses)
      end)
    end
  )

  @impl Commanded.Event.Handler
  def error(_error, _failed_event, _failure_context) do
    :skip
  end
end
