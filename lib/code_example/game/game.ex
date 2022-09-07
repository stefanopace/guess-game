defmodule CodeExample.Game do
  @moduledoc """
  Game aggregate.
  """

  alias CodeExample.Game.Commands.{CreateGame, GuessNumber, JoinGame}
  alias CodeExample.Game.Events.{GameCreated, GameEnded, NumberGuessed, PlayerJoined}
  alias __MODULE__

  defstruct [
    :game_id
  ]

  def execute(%Game{}, %CreateGame{}) do
    :ok
  end

  def execute(%Game{}, %GuessNumber{}) do
    :ok
  end

  def execute(%Game{}, %JoinGame{}) do
    :ok
  end

  # State mutators

  def apply(%Game{} = state, %GameCreated{}) do
    state
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