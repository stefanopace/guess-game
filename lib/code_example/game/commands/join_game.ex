defmodule CodeExample.Game.Commands.JoinGame do
  @moduledoc """
  JoinGame command.
  """

  alias __MODULE__

  @type t :: %JoinGame{
          game_id: String.t()
        }

  defstruct [
    :game_id
  ]
end