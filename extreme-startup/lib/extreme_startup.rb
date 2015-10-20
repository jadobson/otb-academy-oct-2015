require_relative 'number_helpers'
require 'uri'

class ExtremeStartup
  include NumberHelpers
  attr_reader :question

  def initialize(query)
    @question = query

    questions.each do |q|
      if question[q[:exp]]
        return q[:fn].to_s
      end
    end
  end

  def questions
    [
      { :exp => /what is your name/, :fn => name },
      { :exp => /what is \d+ minus \d+$/, :fn => minus },
      { :exp => /what is \d+ plus \d+$/, :fn => sum },
      { :exp => /what is \d+ plus \d+ plus \d+$/, :fn => sum },
      { :exp => /what is \d+ multiplied by \d+$/, :fn => multiply },
      { :exp => /square and a cube/, :fn => square_and_cube },
      { :exp => /primes/, :fn => primes },
      { :exp => /Fibonacci/, :fn => fibonacci },
      { :exp => /to the power of/, :fn => power_of },
    ]
  end

  private

  def name
    'Amber Leaf'
  end

  def sum
    query_numbers.inject(&:+)
  end

  def minus
    query_numbers.inject(&:-)
  end

  def multiply
    query_numbers.inject(&:*)
  end

  def square_and_cube
    query_numbers.select { |n| square_and_cube?(n) }.first
  end

  def primes
    query_numbers.select { |n| prime?(n) }.join(',')
  end

  def fibonacci
    fibonacci_series_number(query_number)
  end

  def power_of
    query_numbers[0] ** query_numbers[1]
  end

  def query_numbers
    question.scan(/\d+/).map { |n| n.to_i }
  end

  def query_number
    query_numbers.first
  end
end
