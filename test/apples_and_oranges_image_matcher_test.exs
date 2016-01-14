defmodule ApplesAndOrangesImageMatcherTest do
  use ExUnit.Case
  alias ApplesAndOranges.ScreenshotSet
  import ApplesAndOranges.TestHelpers

  @matching_test build_set("image_matcher", "matching_test")
  @diffing_test build_set("image_matcher", "diffing_test")
  @empty_test build_set("image_matcher", "empty_test")

  test "matches when the accepted and current images are the same" do
    assert {:ok, _} = ApplesAndOranges.ImageMatcher.matches?(@matching_test)
  end

  test "does not match when the accepted and current images are different" do
    assert {:error, _} = ApplesAndOranges.ImageMatcher.matches?(@diffing_test)
  end

  test "returns an error when there is no accepted image" do
    assert {:raise, _} = ApplesAndOranges.ImageMatcher.matches?(@empty_test)
  end

  test "generates a diff file when the accepted and current images are different" do
    ApplesAndOranges.ImageMatcher.matches?(@diffing_test)
    assert ScreenshotSet.diff_image(@diffing_test)
  end

  test "matches when the accepted and current images match given a fuzz factor" do
    assert ApplesAndOranges.ImageMatcher.matches?(@diffing_test, 80)
  end
end
