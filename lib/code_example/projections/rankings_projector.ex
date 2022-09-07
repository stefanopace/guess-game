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

  project(
    %GameEnded{winning_player: winning_player, losing_player: losing_player},
    _metadata,
    fn multi ->
      multi
      |> Ecto.Multi.run(:winning_player, fn _repo, _changes ->
        {:ok, CodeExample.Repo.get(CodeExample.Projections.Rankings, winning_player)}
      end)
      |> Ecto.Multi.merge(fn %{winning_player: winning_player_record} ->
        case winning_player_record do
          nil ->
            Ecto.Multi.new()
            |> Ecto.Multi.insert(:rankings, %CodeExample.Projections.Rankings{
              player_name: winning_player,
              wins: 1
            })

          %{wins: wins} ->
            Ecto.Multi.new()
            |> Ecto.Multi.update(
              :rankings,
              Ecto.Changeset.change(winning_player_record, wins: wins + 1)
            )
        end
      end)
    end
  )

  @impl Commanded.Event.Handler
  def error(_error, _failed_event, _failure_context) do
    :skip
  end
end
