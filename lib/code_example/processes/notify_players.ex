defmodule CodeExample.Processes.NotifyPlayers do
  @moduledoc """
  NotifyPlayers.
  """

  use Commanded.ProcessManagers.ProcessManager,
    application: CodeExample.App,
    name: __MODULE__,
    start_from: :origin

  alias CodeExample.Game.Events.{GameEnded, NumberGuessed, PlayerJoined}
  alias __MODULE__

  @derive Jason.Encoder
  defstruct [
    :process_uuid
  ]

  @impl Commanded.ProcessManagers.ProcessManager
  def interested?(%GameEnded{}) do
    # TODO: {:start, process_uuid} | {:continue, process_uuid} | {:stop, process_uuid}
  end

  @impl Commanded.ProcessManagers.ProcessManager
  def interested?(%NumberGuessed{}) do
    # TODO: {:start, process_uuid} | {:continue, process_uuid} | {:stop, process_uuid}
  end

  @impl Commanded.ProcessManagers.ProcessManager
  def interested?(%PlayerJoined{}) do
    # TODO: {:start, process_uuid} | {:continue, process_uuid} | {:stop, process_uuid}
  end

  @impl Commanded.ProcessManagers.ProcessManager
  def handle(%NotifyPlayers{}, %GameEnded{}) do
    []
  end

  @impl Commanded.ProcessManagers.ProcessManager
  def handle(%NotifyPlayers{}, %NumberGuessed{}) do
    []
  end

  @impl Commanded.ProcessManagers.ProcessManager
  def handle(%NotifyPlayers{}, %PlayerJoined{}) do
    []
  end

  @impl Commanded.ProcessManagers.ProcessManager
  def apply(%NotifyPlayers{} = state, %GameEnded{}) do
    state
  end

  @impl Commanded.ProcessManagers.ProcessManager
  def apply(%NotifyPlayers{} = state, %NumberGuessed{}) do
    state
  end

  @impl Commanded.ProcessManagers.ProcessManager
  def apply(%NotifyPlayers{} = state, %PlayerJoined{}) do
    state
  end

  @impl Commanded.ProcessManagers.ProcessManager
  def error(_error, _failure_source, _failure_context) do
    :skip
  end
end