defmodule ProgressiveCompilationTest do
  use ExUnit.Case
  alias ProgressiveCompilation

  test "Raise exception if counted value does not exist" do
    assert ProgressiveCompilation.hello(:while_registering) == 0
    assert ProgressiveCompilation.hello(:after_registering) == 1

    assert ProgressiveCompilation.bye(:while_registering) == 1
    assert ProgressiveCompilation.bye(:after_registering) == 2
  end
end
