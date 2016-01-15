defmodule ApplesAndOranges.ScreenshotSetTest do
  use ExUnit.Case
  alias ApplesAndOranges.ScreenshotSet
  use ApplesAndOranges.TestHelpers

  use Hound.Helpers
  hound_session

  @accepted_set build_set("screenshot_set", "accepted_test")
  @empty_set build_set("screenshot_set", "empty_test")
  @everything_set build_set("screenshot_set", "everything_test")
  @open_set build_set("screenshot_set", "open_test")

  test "can find existing accepted image" do
    assert ScreenshotSet.accepted?(@accepted_set)
  end

  test "returns nil when no accepted image is found" do
    refute ScreenshotSet.accepted?(@empty_set)
  end

  test "returns absolute path to accepted image" do
    assert ScreenshotSet.accepted_image_src(@accepted_set)
  end

  test "returns nil absolute path when no accepted image is found" do
    refute ScreenshotSet.accepted_image_src(@empty_set)
  end

  test "accepting a test removes current and diff files" do
    assert ScreenshotSet.accepted?(@everything_set)
    assert ScreenshotSet.diff?(@everything_set)
    assert ScreenshotSet.current?(@everything_set)

    ScreenshotSet.accept!(@everything_set)

    assert ScreenshotSet.accepted_image(@everything_set)
    refute ScreenshotSet.diff_image(@everything_set)
    refute ScreenshotSet.current_image(@everything_set)
  end

  test "accepting creates an accepted image when there is only a current image" do
    assert ScreenshotSet.current_image(@open_set)
    refute ScreenshotSet.accepted_image(@open_set)
    refute ScreenshotSet.diff_image(@open_set)

    ScreenshotSet.accept!(@open_set)

    assert ScreenshotSet.accepted_image(@open_set)
    refute ScreenshotSet.diff_image(@open_set)
    refute ScreenshotSet.current_image(@open_set)
  end
end
