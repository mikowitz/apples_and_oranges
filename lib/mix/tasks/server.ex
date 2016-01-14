defmodule Mix.Tasks.ApplesAndOranges.Server do
  use Mix.Task

  @shortdoc "Starts apples_and_oranges server"

  def run(args) do
    IO.inspect "HELLLO!"
    IO.inspect Application.get_env(:apples_and_oranges, :port)
    Application.put_env(:trot, :port, Application.get_env(:apples_and_oranges, :port))
    Mix.Task.run "trot.server", args
    no_halt
  end

  defp no_halt do
    unless iex_running?, do: :timer.sleep(:infinity)
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) && IEx.started?
  end
end
