defmodule PropTypes do

  def create_type_checker(validate) do
    fn (props, prop_name, caller_name, options) ->
      if Map.has_key?(props, prop_name) == false do
        if Map.has_key?(options, :required) do
          PropTypes.Error.exception(prop_name, caller_name, "prop_types.required")
        else
          nil
        end
      else
        validate.(props, prop_name, caller_name, options)
      end
    end
  end

  def create_primitive_type_checker(expected_type) do
		create_type_checker(fn (props, prop_name, caller_name, _) ->
      value = Map.get(props, prop_name)
			type = Tipo.typeof(value)

			if type != expected_type do
			  PropTypes.Error.exception(prop_name, caller_name, "prop_types.invalid_type")
			else
				nil
			end
		end)
	end

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

  def check(props, prop_types, caller_name) do
    not_nil = fn (x) -> x != nil end

    results = Enum.filter(
      Enum.map(Map.keys(prop_types), fn (prop_name) ->
        props_options = Map.get(prop_types, prop_name)

        funcs = Map.get(props_options, :validations)
        funcs = if Tipo.list?(funcs), do: funcs, else: [funcs]

        results = List.flatten(Enum.filter(
          Enum.map(funcs, fn (func) ->
            result = func.(props, prop_name, caller_name, props_options)

            if result != nil do
              if Tipo.list?(result), do: result, else: [result]
            else
              nil
            end
          end),
          not_nil
        ))

        if results != [] do
          %{prop_name => results}
        else
          nil
        end
      end),
      not_nil
    )

    if results != [] do
      Enum.reduce(results, %{}, fn (value, errors) ->
        Map.merge(errors, value)
      end)
    else
      nil
    end
  end
  def check(props, prop_types), do: check(props, prop_types, "<<anonymous>>")

  def create_checker(prop_types, caller_name) do
    fn (props) ->
      check(props, prop_types, caller_name)
    end
  end
  def create_checker(prop_types), do: create_checker(prop_types, "<<anonymous>>")
end
