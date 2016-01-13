defmodule ApplesAndOranges.Router do
  use Trot.Router
  use Trot.Template
  alias ApplesAndOranges.Test

  plug Plug.Static, at: "/", from: Application.get_env(:apples_and_oranges, :static_app)

  get "/test" do
    query = URI.query_decoder(conn.query_string) |> Enum.map(&(&1)) |> List.first
    {_, path} = query
    IO.inspect "==============> #{path}"
    test = %Test{path: path}
    IO.inspect "==============>"
    IO.inspect test
    Test.accept!(test)
    {:redirect, "/"}
  end

  get "/" do
    IO.inspect System.cwd
    tests = Path.wildcard("priv/static/screens/**/*.{png,jpg}")
    |> Enum.map(&Path.dirname(&1))
    |> Enum.uniq
    |> Enum.map fn path -> %Test{path: path} end
    IO.inspect tests
    render_template("index.html.haml", [tests: tests])
  end

  import_routes Trot.NotFound
end
