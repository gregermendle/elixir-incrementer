defmodule Incrementer.MixProject do
  use Mix.Project

  def project do
    [
      app: :incrementer,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :sqlite_ecto2, :ecto, :cowboy, :plug, :plug_cowboy],
      mod: {Incrementer, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.5"},
      {:plug_cowboy, "~> 1.0"},
      {:sqlite_ecto2, "~> 2.2"}
    ]
  end
end
