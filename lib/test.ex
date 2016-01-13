defmodule ApplesAndOranges.Test do
  defstruct path: ""

  def ensure_directory(test) do
    test.path |> Path.absname |> File.mkdir_p!
  end

  def accepted_image(nil), do: nil
  def accepted_image(test) do
    Path.wildcard(test.path <> "/accepted.{png,jpg}") |> Enum.find(&File.exists?(&1))
  end

  def accepted_image_as_src(nil), do: nil
  def accepted_image_as_src(test) do
    test |> accepted_image |> strip_priv_static
  end

  def current_image(nil), do: nil
  def current_image(test) do
    Path.wildcard(test.path <> "/current.{png,jpg}") |> Enum.find(&File.exists?(&1))
  end

  def diff_image(nil), do: nil
  def diff_image(test) do
    Path.wildcard(test.path <> "/diff.{png,jpg}") |> Enum.find(&File.exists?(&1))
  end

  def current_image_as_src(nil), do: nil
  def current_image_as_src(test) do
    test |> current_image |> strip_priv_static
  end

  def diff_image_as_src(nil), do: nil
  def diff_image_as_src(test) do
    test |> diff_image |> strip_priv_static
  end

  def absolute_path(nil), do: nil
  def absolute_path(path), do: Path.absname(path)

  defp strip_priv_static(nil), do: nil
  defp strip_priv_static(path), do: path |> String.replace("priv/static", "")

  def accepted?(test), do: !!accepted_image(test)
  def current?(test), do: !!current_image(test)
  def diff?(test), do: !!diff_image(test)

  def accept!(test) do
    File.cp(current_image(test), current_image(test) |> String.replace("current.", "accepted."))
    File.rm(current_image(test))
    if diff_image(test) do
      File.rm(diff_image(test))
    end
  end

  def status(test) do
    cond do
      diff?(test) ->
        "diff"
      accepted?(test) ->
        "accepted"
      current?(test) ->
        "current"
    end
  end
end
