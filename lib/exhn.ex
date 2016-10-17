defmodule ExHN do
  @moduledoc """
  Interface to the static endpoints of the Hacker News API.

  See the [API docs](https://github.com/HackerNews/API) for more information.
  """

  alias ExHN.Gateway

  @doc """
  Gets the item with the specified `id`
  """
  @spec item(integer) :: {:ok, map} | {:error, String.t}
  def item(id) do
    "item/#{id}"
    |> Gateway.get
    |> process_response
  end

  @doc """
  Gets the user with the specified `name`
  """
  @spec user(String.t) :: {:ok, map} | {:error, String.t}
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
