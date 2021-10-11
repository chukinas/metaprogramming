defmodule SteppedEval do

  defmacro begin(do: block) do
    quote do
      Module.register_attribute(__MODULE__, :values, accumulate: true)
      @step_index :while_registering
      unquote(block)
      @step_index :after_registering
      unquote(block)
    end
  end

  defmacro register(value) when is_atom(value) do
    quote do
      if @step_index == :while_registering, do: @values unquote(value)
    end
  end

  defmacro add_counter(value) when is_atom(value) do
    quote do
      if @step_index == :after_registering && unquote(value) not in @values do
        raise "`#{unquote(value)}` is not a registered value!"
      end
      def unquote(value)(@step_index) do
        Enum.count(@values, & &1 == unquote(value))
      end
    end
  end

end




defmodule SteppedEval.Caller do

  require SteppedEval

  SteppedEval.begin do
    SteppedEval.register :bye
    SteppedEval.add_counter :bye
    SteppedEval.register :hello
    # Uncomment to see example of compile-time check:
    SteppedEval.add_counter :this_will_raise
    SteppedEval.register :bye
  end

end
