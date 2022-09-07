defmodule CodeExample.Game.Events.NumberGuessed do
  @moduledoc """
  NumberGuessed event.
  """

  alias __MODULE__

  @type t :: %NumberGuessed{
          game_id: String.t(),
          version: pos_integer()
        }

  @derive Jason.Encoder
  defstruct [
    :game_id,
    version: 1
  ]

  defimpl Commanded.Serialization.JsonDecoder do
    def decode(%NumberGuessed{} = event), do: event
  end

  defimpl Commanded.Event.Upcaster do
    def upcast(%NumberGuessed{version: 1} = event, _metadata), do: event
  end
end