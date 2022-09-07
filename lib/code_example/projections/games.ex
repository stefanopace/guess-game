defmodule CodeExample.Projections.Games do
  @moduledoc """
  Games.
  """

  alias __MODULE__

  import Ecto.Query

  use Ecto.Schema

  @primary_key {:game_id, :string, autogenerate: false}
  schema "games" do
    field(:guesses, {:array, :map})
    field(:started, :boolean)
    timestamps()
  end

  def guesses(id) do
    Games
    |> CodeExample.Repo.get(id)
    |> Map.get(:guesses)
  end

  def not_started() do
    Games
    |> where(started: false)
    |> CodeExample.Repo.all()
    |> Enum.map(& &1.game_id)
  end
end
