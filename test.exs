secret = "w+5gCyJ5kaBV/J04kQSD6TtUUqnoomiTr4si16TCNT+nxDi6U8IHZlWIoMhZYWh4"

path =
%ThumborPath{
  source: "https://foto.space.kobrakai.de/site/assets/files/1077/20150819-_ben0528.jpg",
  size: {200, 200}
}
|> ThumborPath.Encoder.build(secret)

URI.new!("https://thumbor.connect.pm/") |> Map.put(:path, "/" <> path) |> URI.to_string() |> IO.inspect
