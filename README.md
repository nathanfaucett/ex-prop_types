# PropTypes [![Build Status](https://travis-ci.org/nathanfaucett/ex-prop_types.svg?branch=master)](https://travis-ci.org/nathanfaucett/ex-prop_types)

Property Type validations and checkers for elixir apps

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add prop_types to your list of dependencies in `mix.exs`:

        def deps do
          [{:prop_types, "~> 0.0.1"}]
        end

  2. Ensure prop_types is started before your application:

        def application do
          [applications: [:prop_types]]
        end

```elixir

props = %{
  "username" => %{
    :validations => [PropTypes.string],
    :required => true
  },
  "password" => %{
    :validations => [PropType.requires("username"), PropTypes.string, min_length(6)],
    :required => true
}

```
