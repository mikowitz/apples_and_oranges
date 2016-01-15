defmodule ApplesAndOranges.TestHelpers do
  defmacro __using__(_) do
    quote do
      import ApplesAndOranges.TestHelpers
    end
  end

  def build_set(test_name, set_name) do
    path = ["priv/static/screens", test_name, set_name] |> Enum.join("/")
    %ApplesAndOranges.ScreenshotSet{path: path}
  end
end
