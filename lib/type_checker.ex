defmodule PropTypes.TypeChecker do


  def create_primitive(expected_type) do
     PropTypes.Checker.create(fn (props, prop_name, caller_name, _) ->
      value = Map.get(props, prop_name)
      type = Tipo.typeof(value)

      if type != expected_type do
        PropTypes.Exception.exception(prop_name, caller_name, "invalid_type")
      else
        nil
      end
    end)
  end
end
