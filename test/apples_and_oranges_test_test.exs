defmodule ApplesAndOrangesTestTest do
  use ExUnit.Case
  alias ApplesAndOranges.Test

  use Hound.Helpers
  hound_session

  @accepted_test %Test{path: "priv/static/screens/accepted_test"}
  @empty_test %Test{path: "priv/static/screens/empty_test"}

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
end
