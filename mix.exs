defmodule ExHN.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exhn,
      version: "0.0.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description,
      package: package,
      deps: deps
   ]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:credo, "~> 0.4", only: [:dev, :test]},
      {:ex_doc, "~> 0.14", only: :dev},
      {:httpoison, "~> 0.9.0"},
      {:poison, "~> 3.0"}
    ]
  end

  defp description do
    """
    Streaming Hacker News API client
    """
  end

  defp package do
    [
      maintainers: ["sotojuan"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/sotojuan/exhn"}
    ]
  end
end
