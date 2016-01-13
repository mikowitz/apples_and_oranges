use Mix.Config

config :apples_and_oranges, port: 1989

config :trot, port: Application.get_env(:apples_and_oranges, :port, 1989)
