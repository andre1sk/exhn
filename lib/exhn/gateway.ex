defmodule ExHN.Gateway do
  @moduledoc false

  use HTTPoison.Base

  def endpoint do
    "https://hacker-news.firebaseio.com/v0/"
  end

  defp process_url(url) do
    endpoint <> url <> ".json"
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
  end
end
