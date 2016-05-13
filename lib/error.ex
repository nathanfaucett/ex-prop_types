defmodule PropTypes.Error do

	defexception [:prop_name, :caller_name, :message]

	def exception(prop_name, caller_name, message) do
		%PropTypes.Error{
      prop_name: prop_name,
      caller_name: caller_name,
			message: message
		}
	end
  
end
