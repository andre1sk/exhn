defmodule ExHN.Live do
  @moduledoc """
  Interface to the live endpoints of the Hacker News API.

  See the [API docs](https://github.com/HackerNews/API#live-data) for more information.
  """

  alias Poison.Parser
  require Logger

  @endpoints [
    :max_item,
    :updates,
    :new_stories,
    :top_stories,
    :best_stories,
    :ask_stories,
    :show_stories,
    :job_stories
  ]

  for name <- @endpoints do
    @doc """
    Returns a `Stream` of new data from the `/#{name |> Atom.to_string}` endpoint
    """
    @spec unquote(name)() :: Enumerable.t
    def unquote(name)() do
      make_stream(unquote(name))
    end

    defp start(unquote(name)) do
      url = unquote(name) |> make_url

      fn () -> HTTPoison.get!(url, %{}, [stream_to: self, recv_timeout: :infinity]) end
    end
  end

  defp make_stream(type) do
    Stream.resource(start(type), &next/1, &finish/1)
  end

  defp next(poison) do
    r = receive do
      %HTTPoison.AsyncChunk{chunk: "event: put\ndata: " <> data} -> parse(data)
    end

    {[r], poison}
  end

  defp finish(poison) do
    Logger.info("Poison stopped")

    :hackney.stop_async(poison.id)
  end

  defp parse(data) do
    data |> Parser.parse!
  end

  defp make_url(name) do
    url = name |> Atom.to_string |> String.replace("_", "")

    "https://s-usc1c-nss-136.firebaseio.com/v0/#{url}.json?ns=hacker-news&sse=true"
  end
end
