defmodule ProgressiveCompilation.Macros do

  defmacro begin(do: block) do
    quote do
      Module.register_attribute(__MODULE__, :values, accumulate: true)
      @compile_step :while_registering
      unquote(block)
      @compile_step :after_registering
      unquote(block)
    end
  end

  defmacro register(value) when is_atom(value) do
    quote do
      if @compile_step == :while_registering, do: @values unquote(value)
    end
  end

  defmacro add_counter_function(value) when is_atom(value) do
    quote bind_quoted: [value: value] do
      if @compile_step == :after_registering && value not in @values do
        raise "`#{value}` is not a registered value!"
      end
      @current_count Enum.count(@values, & &1 == value)
      def unquote(value)(@compile_step), do: @current_count
    end
  end

end




defmodule ProgressiveCompilation do

  require ProgressiveCompilation.Macros
  import ProgressiveCompilation.Macros

  begin do
    add_counter_function :hello
    register :bye
    add_counter_function :bye
    register :hello
    # Uncomment to see example of compile-time check:
    # add_counter_function :this_will_raise
    register :bye
  end

end
