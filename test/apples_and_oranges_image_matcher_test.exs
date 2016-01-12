defmodule ApplesAndOrangesImageMatcherTest do
  use ExUnit.Case
  alias ApplesAndOranges.Test

  setup_all do
    on_exit fn ->
      Path.wildcard("test/priv/static/screens/**/diff.{png,jpg}") |> Enum.map(&File.rm(&1))
    end
  end

  @matching_test %Test{path: "test/priv/static/screens/matching_test"}
  @diffing_test %Test{path: "test/priv/static/screens/diffing_test"}

  test "matches when the accepted and current images are the same" do
    assert ApplesAndOranges.ImageMatcher.matches?(@matching_test)
  end

  test "does not match when the accepted and current images are different" do
    refute ApplesAndOranges.ImageMatcher.matches?(@diffing_test)
  end

  test "generates a diff file when the accepted and current images are different" do
    ApplesAndOranges.ImageMatcher.matches?(@diffing_test)
    assert Test.diff_image(@diffing_test)
  end

  test "matches when the accepted and current images match given a fuzz factor" do
    assert ApplesAndOranges.ImageMatcher.matches?(@diffing_test, 80)
  end
end
