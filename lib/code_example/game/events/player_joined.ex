defmodule CodeExample.Game.Events.PlayerJoined do
  @moduledoc """
  PlayerJoined event.
  """

  alias __MODULE__

  @type t :: %PlayerJoined{
          game_id: String.t(),
          version: pos_integer()
        }

  @derive Jason.Encoder
  defstruct [
    :game_id,
    version: 1
  ]

  defimpl Commanded.Serialization.JsonDecoder do
    def decode(%PlayerJoined{} = event), do: event
  end

  defimpl Commanded.Event.Upcaster do
    def upcast(%PlayerJoined{version: 1} = event, _metadata), do: event
  end
end