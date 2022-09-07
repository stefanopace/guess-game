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

  def execute(%Game{}, %JoinGame{}) do
    :ok
  end

  # State mutators

  def apply(%Game{} = state, %GameCreated{
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

  def apply(%Game{} = state, %PlayerJoined{}) do
    state
  end
end
