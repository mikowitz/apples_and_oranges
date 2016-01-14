defmodule ApplesAndOranges.TestHelpers do
  alias ApplesAndOranges.ScreenshotSet

  def build_set(test_name, set_name), do: %ScreenshotSet{path: "priv/static/screens/" <> test_name <> "/" <> set_name}
end
