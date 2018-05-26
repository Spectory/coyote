# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :coyote,
  ecto_repos: [Coyote.Repo]

# Configures the endpoint
config :coyote, CoyoteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HgTCOwl642x3g+hXp540EzVFDIcXd/eLKdHZeACbybEbnJdy/JN49Y7NgLz/9CSL",
  render_errors: [view: CoyoteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Coyote.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


config :ex_admin,
  repo: Coyote.Repo,
  module: CoyoteWeb,
  modules: [
    CoyoteWeb.ExAdmin.Dashboard,
    CoyoteWeb.ExAdmin.Topic,
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :xain, :after_callback, {Phoenix.HTML, :raw}
