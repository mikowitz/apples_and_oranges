defmodule ApplesAndOrangesTestHelperTest do
  use ExUnit.Case
  use Hound.Helpers
  use ApplesAndOranges.TestHelper
  import ApplesAndOranges.TestHelpers

  alias ApplesAndOranges.ScreenshotSet

  hound_session

  @accepted_set build_set("test_helper", "accepted_test")
  @empty_set build_set("test_helper", "empty_test")

  test "save_screenshot takes a 'current' screenshot" do
    save_screenshot(@accepted_set)
    assert ScreenshotSet.current_image(@accepted_set)
  end

  test "it_looks_right deletes the current screenshot if it matches the accepted screenshot" do
    navigate_to("http://localhost:9090/index.html")
    assert it_looks_right(@accepted_set.path)
    refute ScreenshotSet.current_image(@accepted_set)
  end

  test "it_looks_right returns true if 'current' and 'accepted' screenshots match" do
    navigate_to("http://localhost:9090/index.html")
    assert it_looks_right(@accepted_set.path)
  end

  test "it_looks_right returns false if 'current' and 'accepted' screenshots do not match" do
    refute it_looks_right(@accepted_set.path)
  end

  test "it_looks_right fails if there is no accepted screenshot" do
    navigate_to("http://localhost:9090/index.html")
    assert_raise RuntimeError, fn ->
      it_looks_right(@empty_set.path)
    end
  end

  test "build_path creates the correct directory structure when no test name is passed in", context do
    path = build_path(context)
    assert path == "priv/static/screens/applesandorangestesthelpertest/test-build_path-creates-the-correct-directory-structure-when-no-test-name-is-passed-in"
  end

  test "build_path creates the correct directory structure", context do
    path = build_path(context, "new test")
    assert path == "priv/static/screens/applesandorangestesthelpertest/new-test"
  end
end
