defmodule ExHN.GatewayTest do
  use ExUnit.Case

  test "parses a successful response" do
    body = ExHN.Gateway.get!("item/8863").body

    assert body["by"] == "dhouston"
  end

  test "returns `nil` if nothing is found" do
    body = ExHN.Gateway.get!("item/banana").body

    assert body == nil
  end
end
