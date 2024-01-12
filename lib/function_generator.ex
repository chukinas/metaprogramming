defmodule UsState do
  @moduledoc """
  Demonstrate dynamically creating functions (no macros), Macro.escape
  """

  @type t :: %{
          :abbrev => String.t(),
          :name => String.t()
        }

  state_abbreviations = """
  AL  Alabama
  AK  Alaska
  AZ  Arizona
  PA  Pennsylvania
  DE  Deleware
  WV  West Virginia
  WI  Wisconsin
  WY  Wyoming
  """

  parsed_states =
    state_abbreviations
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " ", parts: 2, trim: true))
    |> IO.inspect()

  for [abbrev, name] <- parsed_states do
    fun_name = String.downcase(abbrev) |> String.to_atom()

    state =
      Macro.escape(%{
        abbrev: abbrev,
        name: String.trim(name)
      })

    @spec unquote(fun_name)() :: t
    def unquote(fun_name)(), do: unquote(state)
  end

  # QUESTION:
  #   Why `Macro.escape`?
  # ANSWER:
  #   Because `unquote` below requires that its arg be an AST.
  #   A map is valid elixir syntax, but must be converted to an AST before passing it to `unquote`.
  #   `Macro.escape` converts its arg into an AST, similar to how `quote` works

  # QUESTION:
  #   Ok, so why didn't we just use `quote`, like this?:
  #   ```
  #   state = quote do
  #     %{
  #       abbrev: abbrev,
  #       name: String.trim(name)
  #     }
  #   end
  #   ```
  # ANSWER:
  #   Because quote/2 is used for creating ASTs from expressions,
  #   while Macro.escape/2 is about creating ASTs from values.
  #   Here, we had a value (a map) that we wanted.
end

"""
__MODULE__.__info__
"""
