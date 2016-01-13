defmodule ApplesAndOrangesTestTest do
  use ExUnit.Case
  alias ApplesAndOranges.Test

  use Hound.Helpers
  hound_session

  @accepted_test %Test{path: "priv/static/screens/accepted_test"}
  @empty_test %Test{path: "priv/static/screens/empty_test"}
  @everything_test %Test{path: "priv/static/screens/everything_test"}
  @open_test %Test{path: "priv/static/screens/open_test"}

  test "can find existing accepted image" do
    assert Test.accepted_image(@accepted_test)
  end

  test "returns nil when no accepted image is found" do
    refute Test.accepted_image(@empty_test)
  end

  test "returns absolute path to accepted image" do
    assert Test.accepted_image_as_src(@accepted_test)
  end

  test "returns nil absolute path when no accepted image is found" do
    refute Test.accepted_image_as_src(@empty_test)
  end

  test "accepting a test removes current and diff files" do
    Test.accept!(@everything_test)
    assert Test.accepted_image(@everything_test)
    refute Test.diff_image(@everything_test)
    refute Test.current_image(@everything_test)
  end

  test "accepting creates an accepted image when there is only a current image" do
    assert Test.current_image(@open_test)
    refute Test.accepted_image(@open_test)
    refute Test.diff_image(@open_test)

    Test.accept!(@open_test)

    assert Test.accepted_image(@open_test)
    refute Test.diff_image(@open_test)
    refute Test.current_image(@open_test)
  end
end
