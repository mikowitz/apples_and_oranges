defmodule ApplesAndOrangesTestHelperTest do
  use ExUnit.Case
  use Hound.Helpers
  use ApplesAndOranges.TestHelper
  use ApplesAndOranges.TestHelpers

  alias ApplesAndOranges.ScreenshotSet

  hound_session

  @accepted_set build_set("test_helper", "accepted_test")
  @empty_set build_set("test_helper", "empty_test")

  test "it_looks_right returns true if 'current' and 'accepted' screenshots match" do
    navigate_to("http://localhost:9090/index.html")
    assert it_looks_right(@accepted_set.path)
  end

  test "it_looks_right deletes the current screenshot if it matches the accepted screenshot" do
    navigate_to("http://localhost:9090/index.html")
    assert it_looks_right(@accepted_set.path)
    refute ScreenshotSet.current_image(@accepted_set)
  end

  test "it_looks_right returns false if 'current' and 'accepted' screenshots do not match" do
    refute it_looks_right(@accepted_set.path)
  end

  test "it_looks_right retains ther 'current' image if it does not match the existing 'accepted'" do
    refute it_looks_right(@accepted_set.path)
    assert ScreenshotSet.current_image(@accepted_set)
  end

  test "it_looks_right raises an error if there is no accepted screenshot" do
    navigate_to("http://localhost:9090/index.html")
    assert_raise RuntimeError, fn ->
      it_looks_right(@empty_set.path)
    end
  end

  test "build_path creates the correct directory structure when no test name is passed in", context do
    navigate_to("http://localhost:9090/index.html")
    assert_raise RuntimeError, fn ->
      it_looks_like(context)
    end
    assert ScreenshotSet.current?(
      %ScreenshotSet{
        path: "priv/static/screens/applesandorangestesthelpertest/test-build_path-creates-the-correct-directory-structure-when-no-test-name-is-passed-in"
      }
    )
  end

  test "build_path creates the correct directory structure", context do
    navigate_to("http://localhost:9090/index.html")
    assert_raise RuntimeError, fn ->
      it_looks_like(context, "new test")
    end
    assert ScreenshotSet.current?(
      %ScreenshotSet{
        path: "priv/static/screens/applesandorangestesthelpertest/new-test"
      }
    )
  end
end
