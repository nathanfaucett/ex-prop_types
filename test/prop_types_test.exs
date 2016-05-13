defmodule PropTypesTest do
  use ExUnit.Case
  doctest PropTypes

  test "should" do
    prop_types = %{
      "username" => %{
        :validations => [PropTypes.string],
        :required => true
      },
      "password" => %{
        :validations => [PropTypes.string],
        :required => true
      }
    }

    checker = PropTypes.create_checker(prop_types)

    result = checker.(%{"username" => "nathanfaucett", "password" => "my_password"})
    assert result == nil

    result = checker.(%{})
    assert(result ==  %{
      "password" => [%PropTypes.Error{
        caller_name: "<<anonymous>>",
        message: "prop_types.required",
        prop_name: "password"
      }],
      "username" => [%PropTypes.Error{
        caller_name: "<<anonymous>>",
        message: "prop_types.required",
        prop_name: "username"
      }]
    })
  end
end
