defmodule ApplesAndOranges.TestHelper do
  alias ApplesAndOranges.ScreenshotSet
  alias ApplesAndOranges.ImageMatcher

  use Hound.Helpers

  defmacro __using__(_opts) do
    quote do
      import ApplesAndOranges.TestHelper
    end
  end

  def it_looks_right(path) do
    test = %ScreenshotSet{path: path}
    ScreenshotSet.ensure_directory(test)
    save_screenshot(test)
    case ImageMatcher.matches?(test) do
      {:ok, _} ->
        IO.inspect test.path <> "/{current,diff}.png"
        IO.inspect Path.wildcard(test.path <> "/{current,diff}.png")
        Path.wildcard(test.path <> "/{current,diff}.png") |> Enum.map &File.rm/1
        true
      {:error, _} -> false
      {:raise, msg} -> raise msg
    end
  end

  def save_screenshot(set) do
    take_screenshot(set.path <> "/current.png")
  end
end
