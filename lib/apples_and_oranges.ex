defmodule ApplesAndOranges do
  alias ApplesAndOranges.ScreenshotSet
  alias ApplesAndOranges.ImageMatcher

  use Hound.Helpers

  defmacro __using__(_opts) do
    quote do
      import ApplesAndOranges
    end
  end

  @screenshot_root_dir ScreenshotSet.screens_root

  def it_looks_like(context, name \\ nil) do
    path = case name do
             nil -> build_path(context)
             _ -> build_path(context, name)
           end
    it_looks_right(path)
  end

  def it_looks_right(path) do
    set = ensure_set_directory(path)
    save_screenshot(set)
    case ImageMatcher.matches?(set) do
      {:ok, _} ->
        Path.wildcard(set.path <> "/{current,diff}.png") |> Enum.map &File.rm/1
        true
      {:error, _} -> false
      {:raise, msg} -> raise msg
    end
  end

  defp ensure_set_directory(path) do
    set = %ScreenshotSet{path: path}
    ScreenshotSet.ensure_directory(set)
    set
  end

  defp save_screenshot(nil), do: nil
  defp save_screenshot(set) do
    take_screenshot(set.path <> "/current.png")
  end

  defp build_path(nil), do: nil
  defp build_path(context), do: build_path(context, Atom.to_string(context.test))
  defp build_path(context, test_name) do
    [@screenshot_root_dir, base_case_name(context.case), test_name]
    |> Enum.join("/")
    |> String.replace(" ", "-")
    |> String.downcase
  end

  defp base_case_name(case_name) do
    Atom.to_string(case_name)
    |> String.split(".")
    |> List.last
  end
end
