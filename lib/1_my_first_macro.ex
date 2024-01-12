defmodule MyFirstMacro.Definition do
  @moduledoc """
  Demonstrate defmacro/2, quote/2
  """

  @doc """
  Insert function hello/0 into caller
  """
  defmacro insert_hello_function do
    quote do
      def hello do
        IO.puts("hello world")
      end
    end
  end
end

defmodule MyFirstMacro do
  import MyFirstMacro.Definition

  insert_hello_function()
end

# A macro is a special type of "function":
#   1) All arguments are AST
#   2) It returns an AST
# quote/2 returns an AST
