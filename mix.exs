defmodule PropTypes.Mixfile do
  use Mix.Project

  def project do
    [app: :prop_types,
     version: "0.0.2",
     description: description,
     package: package,
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:tipo]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:tipo, "~> 0.0.3"},
      {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp description do
   """
   Property Type validations and checkers for elixir apps
   """
 end

  defp package do
    [# These are the default files included in the package
      name: :prop_types,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Nathan Faucett"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/nathanfaucett/ex-prop_types",
        "Docs" => "https://github.com/nathanfaucett/ex-prop_types"
      }
    ]
  end
end
