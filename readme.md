# exhn

> Streaming Hacker News API client

[![Build Status](https://travis-ci.org/sotojuan/exhn.svg?branch=master)](https://travis-ci.org/sotojuan/exhn)

## Install

In your `mix.exs`:

```elixir
def application do
  [applications: [:exhn]]
end

defp deps do
  [
    { :exhn, "~> 0.0.0" }
  ]
end
```

Then run `mix deps.get`.

## Usage

For information about the endpoints themselves please refer to the [Hacker News API docs](https://github.com/HackerNews/API).

### Static endpoints

Static endpoints are available under `ExHN`.

`ExHN.item(id)`

Gets the item with the specified `id`.

`ExHN.user(name)`

Gets the item with the specified `name`.

### Live endpoints

Live endpoints are available under `ExHN.Live`. These return an infinite `Stream` of data. The following endpoints are available:

* `ExHN.max_item`
* `ExHN.updates`
* `ExHN.new_stories`
* `ExHN.top_stories`
* `ExHN.best_stories`
* `ExHN.ask_stories`
* `ExHN.show_stories`
* `ExHN.job_stories `

## License

MIT © [Juan Soto](https://juansoto.me)
