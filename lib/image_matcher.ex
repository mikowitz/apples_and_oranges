defmodule ApplesAndOranges.ImageMatcher do
  alias ApplesAndOranges.ScreenshotSet

  def matches?(set, fuzz \\ 0) do
    if ScreenshotSet.accepted?(set) do
      comparison = compare(set, fuzz)
      case comparison do
        '0' -> {:ok, "Matched"}
        _ -> {:error, "Did not match"}
      end
    else
      {:raise, "No accepted screenshot"}
    end
  end

  defp compare(set, fuzz \\ 0) do
    accepted = ScreenshotSet.absolute_path(ScreenshotSet.accepted_image(set))
    current = ScreenshotSet.absolute_path(ScreenshotSet.current_image(set))
    diff = current |> String.replace("current.", "diff.")
    options = "-metric AE -fuzz #{fuzz}% -dissimilarity-threshold 1 #{accepted} #{current} #{diff}"
    "compare #{options}" |> String.to_char_list |> :os.cmd
  end
end
