defmodule PropTypes.Exception do

  defexception [:prop_name, :caller_name, :message, :data]

  def exception(prop_name, caller_name, msg, data), do: %PropTypes.Exception{
      prop_name: prop_name,
      caller_name: caller_name,
      message: msg,
      data: data
    }
  def exception(prop_name, caller_name, msg), do: %PropTypes.Exception{
      prop_name: prop_name,
      caller_name: caller_name,
      message: msg,
      data: nil
    }
end
