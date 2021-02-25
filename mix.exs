defmodule QscanT.MixProject do
  use Mix.Project

  def project do
    [
      app: :qscant,
      deps: deps(),
      description: description(),
      docs: [main: "QscanT"],
      elixir: "~> 1.9",
      name: "QscanT",
      package: package(),
      source_url: "https://github.com/verypossible-labs/qscant",
      start_permanent: Mix.env() == :prod,
      version: "0.1.1"
    ]
  end

  def application, do: [extra_applications: [:logger]]

  defp deps,
    do: [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]

  defp description, do: "A runtime resolution library. Useful for dependency injection and mocks."

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/verypossible-labs/qscant"}
    ]
  end
end
