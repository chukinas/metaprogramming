defmodule MyUnhygienicMacros do
  defmacro create_get_function do
    quote do
      @my_var var!(my_var)
      def get_my_var do
        @my_var
      end
    end
  end
end


defmodule Caller do
  require MyUnhygienicMacros
  my_var = "happy"
  MyUnhygienicMacros.create_get_function()
  def getenv do
    __ENV__
  end
  def get_attr do
    @my_var
  end
end
