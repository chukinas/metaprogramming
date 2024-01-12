defmodule MacroDefinedByMacroTest do
  use ExUnit.Case

  defmodule DefExec do
    defmacro __using__(module: module) do
      ast =
        quote unquote: false do
          defmacro exec(expr) do
            quote do
              import :__module_placeholder__
              unquote(expr)
            end
          end
        end

      Macro.prewalk(ast, fn
        :__module_placeholder__ -> quote(do: unquote(module))
        other -> other
      end)
    end
  end

  defmodule MapImported do
    use DefExec, module: Map
  end

  test "exec/1 works with fully qualified calls" do
    require MapImported, as: MapImported
    assert %{} == MapImported.exec(Map.new())
  end

  test "exec/1 works with import calls" do
    require MapImported, as: MapImported
    assert %{} == MapImported.exec(new())
  end
end
