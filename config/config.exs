# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chatroom_with_phoenix,
  ecto_repos: [ChatroomWithPhoenix.Repo]

# Configures the endpoint
config :chatroom_with_phoenix, ChatroomWithPhoenix.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "T7W+HjALaiKDyXQhjky0al0quH2nuOIRZ2wzadhRAk4/+imbLSjSVXEULjpNAVVO",
  render_errors: [view: ChatroomWithPhoenix.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ChatroomWithPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
