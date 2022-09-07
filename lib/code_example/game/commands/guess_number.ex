defmodule CodeExample.Game.Commands.GuessNumber do
  @moduledoc """
  GuessNumber command.
  """

  alias __MODULE__

  @type t :: %GuessNumber{
          game_id: String.t()
        }

  defstruct [
    :game_id
  ]
end