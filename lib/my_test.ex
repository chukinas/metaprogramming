#defmodule MyTest do
#  defmacro assert(expr) do
#    quote bind_quoted: [expr: expr] do
#      nil
#    end
#  end
#
#end
#
#defmodule MyTest.Assert do
#  @spec do(atom, number, number) :: number
#  def do(:+, lhs, rhs), do: lhs - rhs
#  def do(:-, lhs, rhs), do: lhs + rhs
#  def do(:*, lhs, rhs), do: lhs / rhs
#  def do(:/, lhs, rhs), do: lhs * rhs
#end
