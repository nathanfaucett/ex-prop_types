defmodule PropTypes.Error do

  defexception [:message]

  def exception(_, _, msg) do
    %PropTypes.Error{
      message: msg
    }
  end

  def message(msg) do
    %PropTypes.Error{
      message: msg
    }
  end

end
