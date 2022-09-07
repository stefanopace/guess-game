defmodule CodeExample.Game.Events.GameCreated do
  @moduledoc """
  GameCreated event.
  """

  alias __MODULE__

  @type t :: %GameCreated{
          game_id: String.t(),
          version: pos_integer()
        }

  @derive Jason.Encoder
  defstruct [
    :game_id,
    :player1,
    :secret_number,
    version: 1
  ]

  defimpl Commanded.Serialization.JsonDecoder do
    def decode(%GameCreated{} = event), do: event
  end

  defimpl Commanded.Event.Upcaster do
    def upcast(%GameCreated{version: 1} = event, _metadata), do: event
  end
end
