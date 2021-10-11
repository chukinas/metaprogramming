# Metaprogramming

This project is an introduction to metaprogramming.



## Abstract Syntax Trees (AST)

In LISP, code looks like this:
```lisp
> (- (+ 3 4) 7)
0
```
Note the two nested functions. Note that the function name at position 0 and the args that follow.
This is an Abstract Syntax Tree. Elixir code looks similar when you peek under the hood.

```elixir
> quote do: 7 - (3 + 4)
{:-, [context: Elixir, import: Kernel],
 [7, {:+, [context: Elixir, import: Kernel], [3, 4]}]}
```
- Note: nested tuples.
- Function name as atom at position 0.
- Args as list at position 2.
- 'Context' at position 1 (You can safely ignore this for now)
- All ASTs are valid high-level Elixir syntax (tuples, lists, atoms, strings)

KEY TAKEAWAY
There are two equally valid ways of representing elixir code: 1) High-Level Syntax and 2) AST.
In any given context, only one of these is valid. e.g. in IEX, only HLS is allowed. e.g. macros (defined using `defmacro`) **always** receive and out put AST.

   - Show LISP syntax - function name first, followed by arguments
   - This is an AST. You can nest this all the way down.
   - Elixir, like many/most (all?) other programming languages is represent by this tree structure.
   - It's just hidden from us, with the nice high-level syntax we're used do.
   - Your first metaprogramming function: `quote`.
   - Some simple elixir syntax Quote a number, string, atom


Show resources. Pay homage to McCord's Metaprogramming book.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `metaprogramming` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:metaprogramming, "~> 0.1.0"}
  ]
end
```
