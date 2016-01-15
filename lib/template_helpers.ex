defmodule ApplesAndOranges.TemplateHelpers do
  def case_name(set), do: set |> name_segment(-2)
  def test_name(set), do: set |> name_segment(-1)

  defp name_segment(set, index) do
    set.path
    |> String.split("/")
    |> Enum.at(index)
    |> String.replace("-", " ")
  end
end
