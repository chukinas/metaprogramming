defmodule OppositeDay.Helpers do
  def do_swap(:+, lhs, rhs), do: lhs - rhs
  def do_swap(:-, lhs, rhs), do: lhs + rhs
  def do_swap(:*, lhs, rhs), do: lhs / rhs
  def do_swap(:/, lhs, rhs), do: lhs * rhs
end

defmodule OppositeDay do
  @moduledoc """
  Demonstrate pattern-matching on ASTs

  This is how ExUnit's assert macro works.
  """

  defmacro swap({operator, _context, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      OppositeDay.Helpers.do_swap(operator, lhs, rhs)
    end
  end
end

"""
ExUnit's assert/1 and assert/2 uses this approach:
  https://hexdocs.pm/ex_unit/master/ExUnit.Assertions.html#assert/1
  It's why there are only 5 different assert functions.
Compare this to jest (a JavaScript testing framework):
  https://jestjs.io/docs/expect
"""
