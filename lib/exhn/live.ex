defmodule ExHN.Live do
  @moduledoc """
  Interface to the live endpoints of the Hacker News API.

  See the [API docs](https://github.com/HackerNews/API#live-data) for more information.
  """

  alias Poison.Parser
  require Logger

  @urls %{
    :max_item => "https://s-usc1c-nss-136.firebaseio.com/v0/maxitem.json?ns=hacker-news&sse=true",
    :updates => "https://s-usc1c-nss-136.firebaseio.com/v0/updates.json?ns=hacker-news&sse=true",
    :new_stories => "https://s-usc1c-nss-136.firebaseio.com/v0/newstories.json?ns=hacker-news&sse=true",
    :top_stories => "https://s-usc1c-nss-136.firebaseio.com/v0/topstories.json?ns=hacker-news&sse=true",
    :best_stories => "https://s-usc1c-nss-136.firebaseio.com/v0/beststories.json?ns=hacker-news&sse=true",
    :ask_stories => "https://s-usc1c-nss-136.firebaseio.com/v0/askstories.json?ns=hacker-news&sse=true",
    :show_stories => "https://s-usc1c-nss-136.firebaseio.com/v0/showstories.json?ns=hacker-news&sse=true",
    :job_stories => "https://s-usc1c-nss-136.firebaseio.com/v0/jobstories.json?ns=hacker-news&sse=true"
  }

  for {name, url} <- @urls do
    @doc """
    Returns a `Stream` of new data from the `/#{name |> Atom.to_string}` endpoint
    """
    def unquote(name)() do
      make_stream(unquote(name))
    end

    defp start(unquote(name)) do
      fn () -> HTTPoison.get!(unquote(url), %{}, [stream_to: self, recv_timeout: :infinity]) end
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
end
