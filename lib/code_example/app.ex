defmodule CodeExample.App do
  @moduledoc false

  use Commanded.Application,
    otp_app: :code_example,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: CodeExample.EventStore
    ]

  router(CodeExample.Router)
end