defmodule Hackernews.MixProject do
  use Mix.Project

  def project do
    [
      app: :hackernews,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      env: [interval: 5000,
        list_url: "https://hacker-news.firebaseio.com/v0/newstories.json",
        story_url: "https://hacker-news.firebaseio.com/v0/item/",
      ],
      mod: {Hackernews.Supervisor, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  def deps do
    [
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.2"}
    ]
  end
end
