defmodule CodeExample.Repo.Migrations.AddRankingsTable do
  use Ecto.Migration

  def change do
    create table(:rankings, primary_key: false) do
      add(:player_name, :string, primary_key: true)
      add(:wins, :integer)
      timestamps(type: :utc_datetime)
    end
  end
end
