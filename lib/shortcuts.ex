defmodule S do
  def create_game(name) do
    CodeExample.App.dispatch(%CodeExample.Game.Commands.CreateGame{game_id: UUID.uuid4(), secret_number: 8, player_name: name})
  end

  def join_game(game_id, name) do
    CodeExample.App.dispatch(%CodeExample.Game.Commands.JoinGame{game_id: game_id, player_name: name})
  end

  def guess(game_id, name, number) do
    CodeExample.App.dispatch(%CodeExample.Game.Commands.GuessNumber{game_id: game_id, player_name: name, number: number})
  end

  def games_not_started() do
    CodeExample.Projections.Games.not_started()
  end

  def disable_logs() do
    Logger.configure level: :error
  end
end
