defmodule ApplesAndOranges.Router do
  use Trot.Router
  use Trot.Template
  alias ApplesAndOranges.Test
  # @template_root "templates"

  plug Plug.Static, at: "/", from: Application.get_env(:apples_and_oranges, :static_app)

  get "/images/:path" do
    IO.inspect "======> #{path}"
  end

  get "/test" do
    "hello"
  end

  get "/" do
    IO.inspect System.cwd
    tests = Path.wildcard("priv/static/screens/**/accepted.{png,jpg}")
    |> Enum.map(&Path.dirname(&1))
    |> Enum.uniq
    |> Enum.map fn path -> %Test{path: path} end
    IO.inspect tests
    render_template("index.html.haml", [tests: tests])
  end

  import_routes Trot.NotFound
end
