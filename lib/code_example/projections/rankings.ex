defmodule CodeExample.Projections.Rankings do
  @moduledoc """
  Rankings.
  """

  alias __MODULE__

  use Ecto.Schema

  @primary_key {:player_name, :string, autogenerate: false}
  schema "rankings" do
    field(:wins, :integer)
    timestamps()
  end

  def all() do
    CodeExample.Repo.all(Rankings)
  end
end
