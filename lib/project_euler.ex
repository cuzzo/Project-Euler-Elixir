defmodule ProjectEuler do
  def main(args) do
    args
      |> parse_args
      |> Problem8.run
      |> IO.puts
  end

  defp parse_args(args) do
    {_, [str], _} = OptionParser.parse(args)
    str
  end
end

defmodule Problem119 do
  @count 30

  def run(str) do
    (for i <- 2..70, j <- 2..10, do: round(:math.pow(i, j)))
      |> Enum.uniq
      |> Enum.sort
      |> Enum.map(fn(x) -> {x, is_digit_power_sum(x)} end)
      |> Enum.filter(fn(x) -> elem(x, 1) == true end)
      |> Enum.map(fn(x) -> elem(x, 0) end)
      |> Enum.at(@count - 1)
  end

  def is_digit_power_sum(i) do
    sum = Integer.digits(i) |> Enum.sum
    if sum < 2 do
      false
    else
      is_digit_power_sum(i, sum, 2)
    end
  end

  def is_digit_power_sum(i, sum, pow) do
    power_sum = :math.pow(sum, pow)
    cond do
       power_sum < i ->
         is_digit_power_sum(i, sum, pow + 1)
       power_sum == i ->
         true
       power_sum > i ->
         false
    end
  end
end

defmodule Problem8 do
  @corpus "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"
  @count 13

  def run(str) do
    0..(String.length(@corpus) - @count)
      |> Enum.map(fn(x) -> ngram_product(String.slice(@corpus, x..(x + (@count - 1)))) end)
      |> Enum.sort
      |> List.last
  end

  defp ngram_product(str) do
    Integer.parse(str) |> elem(0) |> Integer.digits |> Enum.reduce(1, fn(x, acc) -> x * acc end)
  end
end

defmodule Problem7 do
  @count 10001

  def run(str) do
    get_primes([], 0, @count) |> List.last
  end

  defp get_primes(results, n, limit) do
    cond do
      length(results) < limit ->
        if is_prime(n) do
          get_primes(results ++ [n], n + 1, limit)
        else
          get_primes(results, n + 1, limit)
        end
      true ->
        results
    end
  end

  defp is_prime(n) when n == 0 do false end
  defp is_prime(n) when n == 1 do false end

  defp is_prime(n) do
    limit = trunc(:math.sqrt(n))
    cond do
      limit < 2 ->
        true
      limit >= 2 ->
        2..limit
          |> Enum.filter(fn(x) -> n/x == Float.floor(n/x) end)
          |> length == 0
     end
  end
end

defmodule Problem6 do
  @count 100

  def run(str) do
    squared_sum - sum_of_squares
  end

  defp squared_sum do
    1..@count |> Enum.sum |> :math.pow(2)
  end

  defp sum_of_squares do
    1..@count |> Enum.map(fn(x) -> x*x end) |> Enum.sum
  end
end

defmodule Problem5 do
  @factors Enum.to_list(2..20)

  def run(str) do
    solve(@factors, List.last(@factors) + 1)
  end

  defp solve([], n) do
    n
  end

  defp solve([h | t], n) do
    case rem(n, h) do
      0 -> solve(t, n)
      _ -> solve(@factors, n + 1)
    end
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
