defmodule MyFirstUnquote.Definition do
  @moduledoc """
  Demonstrate unquote/1
  """

  @doc """
  Insert function greet/0 into caller
  """
  defmacro insert_greeting(name) do
    quote do
      def greet do
        IO.puts("Hello, " <> unquote(name))
      end
    end
  end
end

defmodule MyFirstUnquote do
  import MyFirstUnquote.Definition

  insert_greeting("Jonathan")
end

# unquote is like string interpolation
# unquote/1 expects a quoted expression
# The quote block knows nothing outside its context
