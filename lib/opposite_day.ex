defmodule OppositeDay.Swap do
  defmodule Undefined, do: defstruct []
  def swap(:+, lhs, rhs), do: lhs - rhs
  def swap(:-, lhs, rhs), do: lhs + rhs
  def swap(:*, lhs, rhs), do: lhs / rhs
  def swap(:/, lhs, rhs), do: lhs * rhs
  def swap(_, _, _), do: %Undefined{}
end

defmodule OppositeDay do
  @moduledoc """
  Demonstrate pattern-matching ASTs, Macro.to_string/1, multiple macro function heads

  Note that very little code gets injected into the caller. The only code we _do_ inject
  delegates out to another module that does the heavy lifting.
  """

  require Logger

  #def warn_unimplemented_ast() do
  #  Logger.warn "No OppositeDay.flip/ implementation for this expression: `#{Macro.to_string ast}`"
  #  ast
  #end

  defmacro flip({operator, _context, [lhs, rhs]} = ast) do
    str_expression = Macro.to_string(ast)
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs, ast: str_expression] do
      case OppositeDay.Swap.swap(operator, lhs, rhs) do
        %OppositeDay.Swap.Undefined{} ->
          # OppositeDay.warn_unimplemented_ast(ast)
          nil
        flipped_result -> flipped_result
      end
    end
  end

  defmacro flip(_ast) do
    #warn_unimplemented_ast(ast)
    nil
  end

end
