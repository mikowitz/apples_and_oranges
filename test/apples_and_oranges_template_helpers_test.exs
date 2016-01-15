defmodule ApplesAndOranges.TemplateHelpersTest do
  use ExUnit.Case
  use ApplesAndOranges.TestHelpers

  alias ApplesAndOranges.TemplateHelpers

  @accepted_set build_set("screenshot_set-name-test", "has-the-right-name")

  test "returns the correct case and test names for a screenshot set" do
    assert "screenshot_set name test" == TemplateHelpers.case_name(@accepted_set)
    assert "has the right name" == TemplateHelpers.test_name(@accepted_set)
  end
end
