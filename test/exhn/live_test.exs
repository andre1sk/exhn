defmodule ExHN.LiveTest do
  use ExUnit.Case

  test "returns data from stream" do
    max_item = ExHN.Live.max_item |> Enum.take(1) |> hd

    assert is_integer(max_item["data"])
  end
end
