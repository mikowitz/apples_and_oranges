defmodule ApplesAndOrangesTestHelperTest do
  use ExUnit.Case
  use Hound.Helpers
  use ApplesAndOranges.TestHelper

  alias ApplesAndOranges.Test

  hound_session

  @accepted_test %Test{path: "priv/static/screens/accepted_test"}
  @empty_test %Test{path: "priv/static/screens/empty_test"}

  test "save_screenshot takes a 'current' screenshot" do
    save_screenshot(@accepted_test)
    assert Test.current_image(@accepted_test)
  end

  test "it_looks_right returns true if 'current' and 'accepted' screenshots match" do
    navigate_to("http://localhost:9090/index.html")
    assert it_looks_right(@accepted_test.path)
  end

  test "it_looks_right returns false if 'current' and 'accepted' screenshots do not match" do
    # navigate nowhere
    refute it_looks_right(@accepted_test.path)
  end

  test "it_looks_right fails if there is no accepted screenshot" do
    navigate_to("http://localhost:9090/index.html")
    assert_raise RuntimeError, fn ->
      it_looks_right(@empty_test.path)
    end
  end
end
