defmodule StructBuilderTest do
  use ExUnit.Case

  # This file builds on the learnings from macro_defined_by_macro.
  # Here we have a macro that defines a macro,
  # and so we need to preserve some unquotes, but evaluate others.
  # The "placeholder atom" works pretty well.
  # Is there a better way to do this? Maybe...?

  defmodule StructBuilder do
    defmacro defstructbuilder(module) do
      ast =
        quote unquote: false do
          defmacro build_struct(kw) do
            quote do
              alias :__module_placeholder__, as: MyStruct
              %MyStruct{unquote_splicing(kw)}
            end
          end
        end

      Macro.prewalk(ast, fn
        :__module_placeholder__ -> quote(do: unquote(module))
        other -> other
      end)
    end
  end

  defmodule MyStruct do
    @enforce_keys [:id]
    defstruct @enforce_keys
  end

  defmodule CallerModule do
    import StructBuilder
    defstructbuilder(MyStruct)
  end

  test "returns a struct" do
    import CallerModule
    assert %MyStruct{id: 123} == build_struct(id: 123)
  end
end
