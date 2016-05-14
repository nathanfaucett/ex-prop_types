defmodule PropTypesTest do
  use ExUnit.Case
  doctest PropTypes

  test "should" do
    prop_types = %{
      #%{
      #  :validations => [PropTypes.string],
      #  :required => true
      #}
      "username" => PropTypes.required(PropTypes.string),
      "password" => PropTypes.required(PropTypes.string),

      "meta" => PropTypes.optional(PropTypes.implements(%{
        "address" => PropTypes.required(PropTypes.string),
        "email" => PropTypes.required(PropTypes.string)
      }))
    }

    checker = PropTypes.create_checker(prop_types, "TestChecker")

    result = checker.(%{"username" => "nathanfaucett", "password" => "my_password"})
    assert result == nil

    result = checker.(%{})
    assert(result ==  %{
      "password" => [%PropTypes.Error{
        message: "prop_types.required"
      }],
      "username" => [%PropTypes.Error{
        message: "prop_types.required"
      }]
    })
    result = checker.(%{"meta" => %{}})
    assert(result ==  %{
      "password" => [%PropTypes.Error{
        message: "prop_types.required"
      }],
      "username" => [%PropTypes.Error{
        message: "prop_types.required"
      }],
      "meta" => [%{
        "address" => [%PropTypes.Error{
          message: "prop_types.required"
        }],
        "email" => [%PropTypes.Error{
          message: "prop_types.required"
        }]
      }]
    })
  end
end
