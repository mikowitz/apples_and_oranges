defmodule ApplesAndOranges.ImageMatcher do
  alias ApplesAndOranges.Test

  def compare(test) do
    accepted = Test.absolute_path(Test.accepted_image(test))
    current = Test.absolute_path(Test.current_image(test))
    # accepted = Test.absolute_path(Test.accepted_image(test))
    diff = accepted |> String.replace("accepted", "diff")
    options = [
      "-metric", "AE",
      "-fuzz", "5%",
      "-dissimilarity-threshold", "1",
      accepted, current, diff]
    System.cmd("compare", options)
  end

  def compare_os(test, fuzz \\ 0) do
    accepted = Test.absolute_path(Test.accepted_image(test))
    current = Test.absolute_path(Test.current_image(test))
    # accepted = Test.absolute_path(Test.accepted_image(test))
    diff = accepted |> String.replace("accepted", "diff")
    options = "-metric AE -fuzz #{fuzz}% -dissimilarity-threshold 1 #{accepted} #{current} #{diff}"
    "compare #{options}" |> String.to_char_list |> :os.cmd
  end

  def matches?(test, fuzz \\ 0) do
    '0' == compare_os(test, fuzz)
  end
end
