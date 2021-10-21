defmodule MyFirstUsing.Definition do
  @moduledoc """
  Demonstrate __using__
  """

  @doc """
  Insert function hello/0 into caller
  """
  defmacro __using__(_opts) do
    quote do
      def hello do
        IO.puts "hello world"
      end
    end
  end

end







defmodule MyFirstUsing do

  use MyFirstUsing.Definition

end









"""
~/monorepo/redline/

Search Redline for '__using__', show examples
~/monorepo/redline/apps/redline_admin/lib/redline_admin_web.ex

Be responsible with __using__. Inject only what you must.
If you have a lot of business logic, put most of it in another module.

`Use`ing this module:
~/monorepo/redline/apps/oem/lib/apis/portal.ex
imports nothing but 13 private functions.
Better would be to put those functions into separate module as publics.
Then in the caller, e.g.:
~/monorepo/redline/apps/oem/lib/apis/portals/bmw_portal.ex
Simply alias that separate module.

Here's a examgle of good __using__:
~/monorepo/redline/apps/redline_core_model/web/web.ex
"""
