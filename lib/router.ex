defmodule ApplesAndOranges.Router do
  use Trot.Router
  use Trot.Template
  alias ApplesAndOranges.ScreenshotSet

  plug Plug.Static, at: "/", from: Application.get_env(:apples_and_oranges, :static_app)

  get "/accept" do
    query = URI.query_decoder(conn.query_string) |> Enum.map(&(&1)) |> List.first
    {_, path} = query
    test = %ScreenshotSet{path: path}
    ScreenshotSet.accept!(test)
    {:redirect, "/"}
  end

  get "/" do
    sets = Path.wildcard("priv/static/screens/**/*.{png,jpg}")
    |> Enum.map(&Path.dirname(&1))
    |> Enum.uniq
    |> Enum.map fn path -> %ScreenshotSet{path: path} end
    render_template("index.html.haml", [sets: sets])
  end

  import_routes Trot.NotFound
end
