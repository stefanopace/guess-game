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

  def execute(
        %Game{
          game_id: game_id,
          current_player: current_player,
          player1: player1,
          player2: player2,
          secret_number: secret_number
        },
        %GuessNumber{
          player_name: player_name,
          number: number
        }
      ) do
    cond do
      current_player == 1 and player_name != player1 ->
        {:error, :not_your_turn}

      current_player == 2 and player_name != player2 ->
        {:error, :not_your_turn}

      true ->
        %NumberGuessed{
          game_id: game_id,
          number: number,
          player_name: player_name,
          outcome: if(number > secret_number, do: :too_high, else: :too_low)
        }
    end
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

  def execute(%Game{game_id: game_id, player1: player1}, %JoinGame{player_name: player_name})
      when not is_nil(player_name) do
    %PlayerJoined{
      game_id: game_id,
      player1: player1,
      player2: player_name
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

  def apply(%Game{current_player: 1} = state, %NumberGuessed{}) do
    %Game{state | current_player: 2}
  end

  def apply(%Game{current_player: 2} = state, %NumberGuessed{}) do
    %Game{state | current_player: 1}
  end

  def apply(%Game{} = state, %PlayerJoined{player2: player2}) do
    %Game{state | player2: player2}
  end
end
