defmodule CodeExample.Game.Commands.CreateGame do
  @moduledoc """
  CreateGame command.
  """

  alias __MODULE__

  @type t :: %CreateGame{
          game_id: String.t()
        }

  defstruct [
    :game_id,
    :secret_number,
    :player_name
  ]
end
