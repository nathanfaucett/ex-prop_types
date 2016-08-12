defmodule PropTypes.Exception do

  defexception [:prop_name, :caller_name, :message]

  def exception(prop_name, caller_name, msg), do: %PropTypes.Exception{
      prop_name: prop_name,
      caller_name: caller_name,
      message: msg
    }

end
