import Config

config :code_example, CodeExample.EventStore,
  username: "postgres",
  password: "postgres",
  database: "code_example_dev",
  hostname: "localhost"

config :code_example, CodeExample.Repo,
  username: "postgres",
  password: "postgres",
  database: "code_example_dev",
  hostname: "localhost"