use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :coyote, CoyoteWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :coyote, Coyote.Repo,
  adapter: Sqlite.Ecto2,
  database: "db/coyote_test.sqlite3",
  pool: Ecto.Adapters.SQL.Sandbox