defmodule CodeExample.Repo.Migrations.AddGamesTable do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add(:game_id, :string, primary_key: true)
      add(:guesses, {:array, :map})
      add(:started, :boolean)
      timestamps(type: :utc_datetime)
    end
  end
end
