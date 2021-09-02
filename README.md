# Metaprogramming

This project is an introduction to metaprogramming.



## Abstract Syntax Trees (AST)

In LISP, code looks like this:
```lisp
> (- (+ 3 4) 7)
0
```

   - Show LISP syntax - function name first, followed by arguments
   - This is an AST. You can nest this all the way down.
   - Elixir, like many/most (all?) other programming languages is represent by this tree structure.
   - It's just hidden from us, with the nice high-level syntax we're used do.
   - Your first metaprogramming function: `quote`.
   - Some simple elixir syntax Quote a number, string, atom

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
