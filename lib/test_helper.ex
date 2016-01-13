defmodule ApplesAndOranges.TestHelper do
  alias ApplesAndOranges.Test
  alias ApplesAndOranges.ImageMatcher

  use Hound.Helpers

  defmacro __using__(_opts) do
    quote do
      import ApplesAndOranges.TestHelper
    end
  end

  def it_looks_right(path) do
    test = %Test{path: path}
    Test.ensure_directory(test)
    save_screenshot(test)
    case ImageMatcher.matches?(test) do
      {:ok, _} ->
        File.wildcard(test.path <> "/diff.png") |> Enum.map(&File.rm(&1))
        File.wildcard(test.path <> "/current.png") |> Enum.map(&File.rm(&1))
        true
      {:error, _} -> false
      {:raise, msg} -> raise msg
    end
  end

  def save_screenshot(test) do
    take_screenshot(test.path <> "/current.png")
  end
end
