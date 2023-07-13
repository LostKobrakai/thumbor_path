# ThumborPath

<!-- MDOC !-->

Elixir library to create or parse [thumbor](https://thumbor.readthedocs.io/en/latest/usage.html) paths.

## Usage

```elixir
iex> secret = "abcdef"
iex>
iex> path =
...>   %ThumborPath{
...>     source: "https://source.unsplash.com/TCpfPxKPOvk/800x800",
...>     crop: {{100, 100}, {750, 750}},
...>     size: {200, 200}
...>   }
...>   |> ThumborPath.build(secret)
iex>
iex> URI.new!("https://thumbor.example.com/")
...> |> Map.put(:path, path)
...> |> URI.to_string()
"https://thumbor.example.com/A0LrsiL0V_fUSCx_ggL6udnRTfE=/100x100:750x750/200x200/https%3A%2F%2Fsource.unsplash.com%2FTCpfPxKPOvk%2F800x800"
```

<!-- MDOC !-->

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `thumbor_path` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:thumbor_path, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/thumbor_path>.

