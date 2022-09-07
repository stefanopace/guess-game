defmodule CodeExample.Game.Events.GameEnded do
  @moduledoc """
  GameEnded event.
  """

  alias __MODULE__

  @type t :: %GameEnded{
          game_id: String.t(),
          version: pos_integer()
        }

  @derive Jason.Encoder
  defstruct [
    :game_id,
    :winning_player,
    :losing_player,
    version: 1
  ]

  defimpl Commanded.Serialization.JsonDecoder do
    def decode(%GameEnded{} = event), do: event
  end

  defimpl Commanded.Event.Upcaster do
    def upcast(%GameEnded{version: 1} = event, _metadata), do: event
  end
end
