module NumberHelpers
  private

  def prime?(n)
    (2..n/2).none?{ |i| n % i == 0 }
  end

  def fibonacci_series_number(n)
    return n if (0..1).include? n
    (fibonacci_series_number(n - 1) + fibonacci_series_number(n - 2))
  end

  def square_and_cube?(n)
    Math.sqrt(n) % 1 == 0 && Math.cbrt(n) % 1 == 0
  end
end
