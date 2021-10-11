defmodule ProgressiveCompilation.Macros do
  @moduledoc """
  Demonstrate how to compile a code block over several passes

  This module is a ridiculously contrived example, but I actually used this kind
  of strategy to solve a problem while building a State Machine library.

  Imagine I want a DSL that lets the user write a state machine like this:

  ```
  defmachine :light_switch do
    defstate :off do
      on :flip_up, goto: :on
    end
    defstate :on do
      on :flip_down, goto: :off
    end
  end
  ```

  This was simple enough to implement until I wanted to add in compile-time checks
  to prevent adding a `goto` state that wasn't defined by the `state` macros.
  For example, I wanted this to raise a compiletime exception:

  ```
  defmachine :light_switch do
    defstate :off do
      on :flip_up, goto: :this_state_doesnt_exist # <- Raise exception here!
    end
    defstate :on do
      on :flip_down, goto: :off
    end
  end
  ```

  Using this progressive compilation, I could do the following:
  1) First pass: accumulate all the states defined by `defstate`
  2) Second pass: define all transitions, checking each against
     the previously accumulated states.
  """

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
      def unquote(value)(@compile_step) do
        Enum.count(@values, & &1 == unquote(value))
      end
    end
  end

end




defmodule ProgressiveCompilation do

  require ProgressiveCompilation.Macros
  import ProgressiveCompilation.Macros

  begin do
    # $ hello(:while_registering)
    # 0
    # $ hello(:after_registering)
    # 1
    add_counter_function :hello
    register :bye
    # $ bye(:while_registering)
    # 1
    # $ bye(:after_registering)
    # 2
    add_counter_function :bye
    register :hello
    # Uncomment to see example of compile-time check:
    # add_counter_function :this_will_raise
    register :bye
  end

end
