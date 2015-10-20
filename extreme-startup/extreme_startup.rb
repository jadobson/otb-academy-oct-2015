require 'sinatra'

set :bind, '0.0.0.0'
set :port, 4567

def prime?(n)
  (2..n/2).none?{ |i| n % i == 0 }
end

def fibonacci(n)
  return n if (0..1).include? n
  (fibonacci(n - 1) + fibonacci(n - 2))
end

get '/' do
  #what is your name
  #what is num plus num
  #which is the following is the largest
  query = params['q']
  decoded_query = URI.unescape(query)
  query_id, question = decoded_query.split(':', 2)

  p question

  numbers = question.scan(/\d+/).map { |num| num.to_i }
  p numbers

  if question[/what is your name/]
    'Amber Leaf'
  elsif question[/what is \d+ minus \d+/]
    (numbers[0] - numbers[1]).to_s


  elsif question[/what is \d+ plus \d+$/] || question[/what is \d+ plus \d+ plus \d+/]
    (numbers.inject(:+)).to_s


  elsif question[/what is \d+ plus \d+ multiplied by \d+/]
    ((numbers[0] + numbers[1]) * numbers[2]).to_s

  elsif question[/what is \d+ multiplied by \d+/]
    (numbers[0] * numbers[1]).to_s


  elsif question[/what is \d+ multiplied by \d+ plus \d+/]
    ((numbers[0] * numbers[1]) + numbers[2]).to_s


  elsif question[/which of the following numbers is the largest: .+/]
    numbers.max.to_s


  elsif question[/which of the following numbers are primes: .+/]
    primes = numbers.select { |number| prime?(number) }
    primes.join(',')


  elsif question[/which of the following numbers is both a square and a cube: .+/]
    matching_numbers = numbers.select do |number|
      Math.sqrt(number) % 1 == 0 && Math.cbrt(number) % 1 == 0
    end
    matching_numbers.first.to_s


  elsif question[/who played James Bond in the film Dr No/]
    'Sean Connery'


  elsif question[/what colour is a banana/]
    'Yellow'


  elsif question[/what currency did Spain use before the Euro/]
    'Peseta'


  elsif question[/who is the Prime Minister of Great Britain/]
    'David Cameron'


  elsif question[/which city is the Eiffel tower in/]
    'Paris'


  elsif question[/what is the \d+\w+ number in the Fibonacci sequence/]
    fibonacci(numbers.first).to_s


  elsif question[/what is \d+ to the power of \d+/]
    (numbers[0] ** numbers[1]).to_s
  end
end

not_found do
  'Not found'
end

error do
  'error'
end
