# Metaprogramming

Examples of metaprogramming syntax

# TOC

- quote/2
    MyFirstMacro.hello/0
    ./lib/1_my_first_macro.ex

- __using__
    MyFirstUsing.hello/0
    ./lib/2_my_first_using.ex

- unquote/1
    MyFirstUnquote.greet/0
    ./lib/3_my_first_unquote.ex

- pattern-matching on AST
    ./lib/opposite_day.ex

- progressive build steps
    ./lib/progressive_compilation.ex

- Macro.escape
  generating functions
   UsState.pa/0
    ./lib/function_generator.ex

- @external_resource
   StateAbbreviations.FromExternalResource.pa/0
   ./lib/state_abbreviations.ex





# Examples outside this repo:

Example of use/2
   Redline.WebStore.Web
   ~/monorepo/redline/apps/redline_web_store/web/web.ex
   ~/monorepo/redline/apps/redline_web_store/web/controllers/account_controller.ex

Example of dynamically generated function heads
   (For readability: easier to read a table that a list of maps)
   ~/projects/dreadnought/apps/suns_core/lib/mission/battlegroup_class.ex


Examgle of watched external resource
   ~/projects/dreadnought/apps/dreadnought/lib/sprite/importer.ex

Example of Redline Core:
   ~/monorepo/redline/apps/redline_core_model/lib/core_model/module_attribute.ex
