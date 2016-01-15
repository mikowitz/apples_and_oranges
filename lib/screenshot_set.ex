defmodule ApplesAndOranges.ScreenshotSet do
  defstruct path: ""

  @screens_root "priv/static/screens"

  def screens_root, do: @screens_root

  def ensure_directory(set) do
    set.path |> absolute_path |> File.mkdir_p!
  end

  ~w(accepted current diff) |> Enum.each fn file_type ->
    def unquote(:"#{file_type}_image")(set), do: set |> image_named(unquote(file_type))
    def unquote(:"#{file_type}_image_src")(set), do: set |> image_src(unquote(file_type))
    def unquote(:"#{file_type}?")(set), do: !!(set |> image_named(unquote(file_type)))
  end

  defp image_named(nil, _), do: nil
  defp image_named(set, name) do
    Path.wildcard(set.path <> "/" <> name <> ".{png,jpg}") |> Enum.find &File.exists?/1
  end

  defp image_src(nil, _), do: nil
  defp image_src(set, name) do
    case image_named(set, name) do
      nil -> nil
      file -> file |> Path.relative_to("priv/static")
    end
  end

  def accept!(nil), do: nil
  def accept!(set) do
    accepted_filename = current_image(set) |> String.replace("current.", "accepted.")
    File.cp(current_image(set), accepted_filename)
    File.rm(current_image(set))
    remove(current_image(set))
    remove(diff_image(set))
  end

  def remove(nil), do: nil
  def remove(file), do: File.rm(file)

  def absolute_path(nil), do: nil
  def absolute_path(path), do: Path.absname(path)

  def status(nil), do: nil
  def status(set) do
    cond do
      diff?(set) -> "diff"
      accepted?(set) -> "accepted"
      current?(set) -> "current"
    end
  end
end
