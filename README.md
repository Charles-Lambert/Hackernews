# Hackernews

Periodically requests the metadata associated with the latest hackernews article.  

Begin supervision tree using 
```elixir
Hackernews.Supervisor.start_link 
```  
Get latest title using 
```elixir
Hackernews.Client.latest_title
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `hackernews` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:hackernews, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/hackernews](https://hexdocs.pm/hackernews).

