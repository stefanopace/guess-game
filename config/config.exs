import Config

config :code_example,
  ecto_repos: [CodeExample.Repo],
  event_stores: [CodeExample.EventStore]

config :code_example, CodeExample.Repo, migration_source: "ecto_migrations"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"