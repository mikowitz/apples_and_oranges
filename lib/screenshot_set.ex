defmodule ApplesAndOranges.ScreenshotSet do
  defstruct path: ""

  def ensure_directory(set) do
    set.path |> Path.absname |> File.mkdir_p!
  end

  def accepted_image(set), do: set |> image_named("accepted")
  def current_image(set), do: set |> image_named("current")
  def diff_image(set), do: set |> image_named("diff")

  def accepted_image_src(set), do: set |> image_src("accepted")
  def current_image_src(set), do: set |> image_src("current")
  def diff_image_src(set), do: set |> image_src("diff")

  defp image_named(nil, _), do: nil
  defp image_named(set, name) do
    Path.wildcard(set.path <> "/" <> name <> ".{png,jpg}") |> Enum.find &File.exists?/1
  end

  defp image_src(nil, _), do: nil
  defp image_src(set, name) do
    case image_named(set, name) do
      nil -> nil
      file -> file |> String.replace("priv/static", "")
    end
  end

  def accepted?(set), do: !!accepted_image(set)
  def current?(set), do: !!current_image(set)
  def diff?(set), do: !!diff_image(set)

  def accept!(set) do
    accepted_filename = current_image(set) |> String.replace("current.", "accepted.")
    File.cp(current_image(set), accepted_filename)
    File.rm(current_image(set))
    if diff?(set) do
      File.rm(diff_image(set))
    end
  end

  def absolute_path(nil), do: nil
  def absolute_path(path), do: Path.absname(path)

  def status(set) do
    cond do
      diff?(set) ->
        "diff"
      accepted?(set) ->
        "accepted"
      current?(set) ->
        "current"
    end
  end
end
