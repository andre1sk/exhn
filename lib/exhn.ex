defmodule ExHN do
  @moduledoc false

  alias ExHN.Gateway

  def item(id) do
    "item/#{id}"
    |> Gateway.get
    |> process_response
  end

  def user(name) do
    "user/#{name}"
    |> Gateway.get
    |> process_response
  end

  defp process_response({:ok, response}) do
    case response.body do
      nil ->
        {:error, "Resource not found"}
      body ->
        {:ok, body}
    end
  end
end
