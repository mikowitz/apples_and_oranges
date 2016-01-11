defmodule ApplesAndOranges.Router do
  use Trot.Router

  get "/" do
    "hello" <> Integer.to_string(Application.get_env(:apples_and_oranges, :port))
  end

  import_routes Trot.NotFound
end
