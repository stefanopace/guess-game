defmodule CodeExample.Game do
  @moduledoc """
  Game aggregate.
  """

  alias CodeExample.Game.Commands.{CreateGame, GuessNumber, JoinGame}
  alias CodeExample.Game.Events.{GameCreated, GameEnded, NumberGuessed, PlayerJoined}
  alias __MODULE__

  defstruct [
    :game_id,
    :secret_number,
    :player1,
    :player2,
    :current_player,
    :ended
  ]

  def execute(%Game{game_id: id}, %CreateGame{}) when not is_nil(id) do
    {:error, :this_game_already_exists}
  end

  def execute(%Game{}, %CreateGame{player_name: ""}) do
    {:error, :player_name_cannot_be_empty}
  end

  def execute(%Game{game_id: nil}, %CreateGame{
        game_id: game_id,
        secret_number: secret_number,
        player_name: player_name
      }) do
    %GameCreated{
      game_id: game_id,
      secret_number: secret_number,
      player1: player_name
    }
  end

  def execute(%Game{}, %GuessNumber{}) do
    :ok
  end

  def execute(%Game{player2: player2}, %JoinGame{}) when not is_nil(player2) do
    {:error, :this_game_already_started}
  end

  def execute(%Game{player1: player1}, %JoinGame{player_name: player1}) do
    {:error, :cannot_join_your_own_games}
  end

  def execute(%Game{}, %JoinGame{player_name: ""}) do
    {:error, :player_name_cannot_be_empty}
  end

  def execute(%Game{game_id: game_id, player1: player1}, %JoinGame{player_name: player_name}) when not is_nil(player_name) do
    %PlayerJoined{
      game_id: game_id,
      player1: player1,
      player2: player_name,
    }
  end

  # State mutators

  def apply(%Game{}, %GameCreated{
        game_id: game_id,
        secret_number: secret_number,
        player1: player_name
      }) do
    %Game{
      game_id: game_id,
      secret_number: secret_number,
      player1: player_name,
      player2: nil,
      current_player: 1,
      ended: false
    }
  end

  def apply(%Game{} = state, %GameEnded{}) do
    state
  end

  def apply(%Game{} = state, %NumberGuessed{}) do
    state
  end

  def apply(%Game{} = state, %PlayerJoined{player2: player2}) do
    %Game{state | player2: player2}
  end
end
