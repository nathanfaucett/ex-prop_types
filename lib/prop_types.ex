defmodule PropTypes do


  def create_type_checker(validate), do: PropTypes.Checker.create(validate)
  def create_primitive_type_checker(expected_type), do: PropTypes.TypeChecker.create_primitive(expected_type)

  def create_checker(prop_types, caller_name), do: PropTypes.Checker.create_checker(prop_types, caller_name)
  def create_checker(prop_types), do: PropTypes.Checker.create_checker(prop_types)

  def check(props, prop_types, caller_name), do: PropTypes.Checker.check(props, prop_types, caller_name)
  def check(props, prop_types), do: PropTypes.Checker.check(props, prop_types)

  def atom(), do: create_primitive_type_checker(:atom)
  def boolean(), do: create_primitive_type_checker(:boolean)
  def number(), do: create_primitive_type_checker(:number)
  def integer(), do: create_primitive_type_checker(:integer)
  def float(), do: create_primitive_type_checker(:float)
  def string(), do: create_primitive_type_checker(:string)
  def bitstring(), do: create_primitive_type_checker(:bitstring)
  def function(), do: create_primitive_type_checker(:function)
  def list(), do: create_primitive_type_checker(:list)
  def map(), do: create_primitive_type_checker(:map)
  def tuple(), do: create_primitive_type_checker(:tuple)

  def implements(expected_interface) do
    Enum.each(Map.keys(expected_interface), fn (prop_name) ->
      if Tipo.map?(Map.get(expected_interface, prop_name)) == false do
        raise (
          "Invalid Function Interface for " <> prop_name <> " must be functions, " <>
          "(props: Map, prop_name: String, caller_name: String) return array of errors, error, or null."
        )
      end
    end)

    PropTypes.Checker.create(fn (props, prop_name, caller_name, _) ->
      PropTypes.Checker.check(Map.get(props, prop_name), expected_interface, caller_name <> "." <> prop_name)
    end)
  end

  def required(validations), do: %{
      :validations => validations,
      :required => true
    }

  def optional(validations), do: %{
      :validations => validations,
      :required => false
    }
end
