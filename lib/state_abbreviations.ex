defmodule StateAbbreviations.FromExternalResource do

  # *** *******************************
  # *** TYPES

  # This is a special module attribute that has Elixir watch
  # this file for changes. So while you're in DEV, you can make
  # edits to the file and see your app refresh on save.
  @external_resource "state_abbreviations.csv"

  @type t :: %{
    :abbrev => String.t,
    :name => String.t
  }

  parsed_states =
    @external_resource
    |> Path.expand(__DIR__)
    |> File.stream!
    |> CSV.decode
    |> Enum.to_list
    |> IO.inspect

  # Aside from the different pattern match, this list comprehension
  # is exactly the same as StateAbbreviations.FromString
  for {:ok, [name, _, abbrev]} <- parsed_states do
    fun_name = String.downcase(abbrev) |> String.to_atom
    state = Macro.escape(%{
      abbrev: abbrev,
      name: String.trim(name)
    })
    def unquote(fun_name)(), do: unquote(state)
  end

end
