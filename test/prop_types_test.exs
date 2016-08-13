defmodule PropTypesTest do
  use ExUnit.Case
  doctest PropTypes


  def min_length(size),
    do: PropTypes.create_type_checker(fn (props, prop_name, caller_name, _) ->
      value = Map.get(props, prop_name)

      if String.length(value) < size do
        PropTypes.Exception.exception(prop_name, caller_name, "min_length")
      else
        nil
      end
    end)
  def requires(some_prop_name),
    do: PropTypes.create_type_checker(fn (props, prop_name, caller_name, _) ->
      if !Map.has_key?(props, some_prop_name) do
        PropTypes.Exception.exception(prop_name, caller_name, "requires_prop", some_prop_name)
      else
        nil
      end
    end)

  test "should" do
    prop_types = %{
      "username" => PropTypes.required([PropTypes.string]),
      "password" => PropTypes.required([requires("username"), PropTypes.string, min_length(6)]),

      "meta" => PropTypes.optional([PropTypes.implements(%{
        "address" => PropTypes.required([PropTypes.string]),
        "email" => PropTypes.required([PropTypes.string])
      })])
    }

    checker = PropTypes.create_checker(prop_types, "TestChecker")

    result = checker.(%{"username" => "nathanfaucett", "password" => "my_password"})
    assert result == nil

    result = checker.(%{})
    assert(result ==  %{
      "username" => [
        %PropTypes.Exception{
          caller_name: "TestChecker",
          data: nil,
          message: "required",
          prop_name: "username"
        }],
        "password" => [
          %PropTypes.Exception{
            caller_name: "TestChecker",
            data: nil,
            message: "required",
            prop_name: "password"
          },
          %PropTypes.Exception{
            caller_name: "TestChecker",
            data: nil,
            message: "required",
            prop_name: "password"
          },
          %PropTypes.Exception{
            caller_name: "TestChecker",
            data: nil,
            message: "required",
            prop_name: "password"
          }
        ]
      })

    result = checker.(%{"meta" => %{}})
    assert(result == %{
      "meta" => [%{
        "address" => [
          %PropTypes.Exception{
            caller_name: "TestChecker.meta",
            data: nil,
            message: "required",
            prop_name: "address"
          }
        ],
        "email" => [
          %PropTypes.Exception{
            caller_name: "TestChecker.meta",
            data: nil,
            message: "required",
            prop_name: "email"
          }
        ]
      }],
      "username" => [
        %PropTypes.Exception{
          caller_name: "TestChecker",
          data: nil,
          message: "required",
          prop_name: "username"
        }
      ],
      "password" => [
        %PropTypes.Exception{
          caller_name: "TestChecker",
          data: nil,
          message: "required",
          prop_name: "password"
        },
        %PropTypes.Exception{
          caller_name: "TestChecker",
          data: nil,
          message: "required",
          prop_name: "password"
        },
        %PropTypes.Exception{
          caller_name: "TestChecker",
          data: nil,
          message: "required",
          prop_name: "password"
        }
      ]
    })
  end
end
