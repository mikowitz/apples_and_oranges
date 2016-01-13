defmodule ApplesAndOranges.TestHelpers do
  alias ApplesAndOranges.ScreenshotSet

  def build_set(set_name), do: %ScreenshotSet{path: "priv/static/screens/" <> set_name}
end
