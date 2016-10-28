defmodule ProjectEuler do
  def main(args) do
    args
      |> parse_args
      |> Problem4.run
      |> IO.puts
  end

  defp parse_args(args) do
    {_, [str], _} = OptionParser.parse(args)
    str
  end
end

defmodule Problem4 do
  defp is_palindrome(i) do
    str = Integer.to_string(i)
    len = String.length(str)
    m_floor = round(Float.floor(len / 2))
    m_ceil = round(Float.ceil(len / 2))
    String.slice(str, 0, m_floor) == String.slice(str, m_ceil, len) |> String.reverse
  end

  def run(str) do
    (for i <- 1..999, j <- 1..999, do: i*j)
      |> Enum.filter(fn(x) -> is_palindrome(x) end)
      |> Enum.sort
      |> List.last
  end
end

defmodule Problem3 do
  def run(str) do
    s = 600851475143
    2..round(:math.sqrt(s))
      |> Enum.filter(fn(x) -> rem(s, x) === 0 end)
      |> Enum.map(fn(x) -> [x, round(s / x)] end)
      |> List.flatten
      |> Enum.sort
      |> Enum.filter(fn(x) -> Enum.filter(2..round(:math.sqrt(x)), fn(y) -> rem(x, y) == 0 end) |> Enum.count == 0 end)
      |> List.last
  end
end

defmodule Problem2 do
  defp fib(a, _, 0) do a end
  defp fib(a, b, n) do fib(b, a+b, n-1) end

  def run(str) do
    (0..32
      |> Enum.map(fn(x) -> fib(1, 1, x) end)
      |> Enum.filter(fn(x) -> rem(x, 2) == 0 end)
      |> Enum.sum
    )
  end
end

defmodule Problem1 do
  def run(str) do
     0..999
       |> Enum.filter(fn(x) -> rem(x, 3) == 0 or rem(x, 5) == 0 end)
       |> Enum.reduce(fn(x, acc) -> acc + x end)
  end
end
