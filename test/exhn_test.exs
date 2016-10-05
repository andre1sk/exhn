defmodule ExHNTest do
  use ExUnit.Case

  test "gets an item" do
    {:ok, item} = ExHN.item(100)
    assert item["by"] == "pc"
  end

  test "gets a user" do
    {:ok, user} = ExHN.user("pg")
    assert user["created"] == 1160418092
  end
end
