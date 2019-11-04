use Mix.Config

config :incrementer, Numbers.Repo,
  adapter: Sqlite.Ecto2,
  database: "numbers.sqlite3"

config :incrementer, ecto_repos: [Numbers.Repo]
