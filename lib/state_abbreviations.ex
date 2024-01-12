defmodule StateAbbreviations.FromExternalResource do
  @moduledoc """
  Do expensive parsing at compile-time

  Other advantages include:
  1. separating data from code
  2. keeping data in a more readable format, or its original format

  For details on the other details of this module, see
  `UsState`.
  """

  # *** *******************************
  # *** TYPES

  # The `@external_resource` module attribute declares an
  # external file as a dependency, similar to `requir`ing
  # an Elixir module. Modifying the external file will force
  # a recompile of this module.
  @external_resource "state_abbreviations.csv"

  @type t :: %{
          :abbrev => String.t(),
          :name => String.t()
        }

  Module.register_attribute(__MODULE__, :state_count, accumulate: true)

  parsed_states =
    @external_resource
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> CSV.decode()
    |> Enum.to_list()

  for {:ok, [name, _, abbrev]} <- parsed_states do
    @state_count abbrev
    fun_name = String.downcase(abbrev) |> String.to_atom()

    state =
      Macro.escape(%{
        abbrev: abbrev,
        name: String.trim(name)
      })

    def unquote(fun_name)(), do: unquote(state)
  end

  # This is just a sanity check to confirm that we generated
  # correct number of functions. Has no effect on the final
  # compiled module but will throw at compile-time if the
  # pattern-match fails (i.e. if we're missing one of more states).
  52 = Enum.count(@state_count)
end

"""
This file might have been a good candidate for this approach:
~/monorepo/redline/apps/redline_core_model/web/models/state_province.ex
"""
