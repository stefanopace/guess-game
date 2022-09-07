defmodule CodeExample.Router do
  @moduledoc false

  use Commanded.Commands.Router

  alias CodeExample.Game
  alias CodeExample.Game.Commands.{CreateGame, GuessNumber, JoinGame}

  identify(Game, by: :game_id, prefix: "game-")

  dispatch([CreateGame, GuessNumber, JoinGame], to: Game)
end