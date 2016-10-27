defmodule ProjectEuler do
  def main(args) do
    args
      |> parse_args
      |> run
      |> IO.puts
  end

  defp parse_args(args) do
    {_, [str], _} = OptionParser.parse(args)
    str
  end

  defp run(str) do
     0..999
       |> Enum.filter(fn(x) -> rem(x, 3) == 0 or rem(x, 5) == 0 end)
       |> Enum.reduce(fn(x, acc) -> acc + x end)
  end
end
