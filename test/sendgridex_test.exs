defmodule SendGridExTest do
  use ExUnit.Case
  doctest SendGridEx

  test "greets the world" do
    assert SendGridEx.hello() == :world
  end
end
