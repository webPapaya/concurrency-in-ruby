require 'benchmark'

class Fibonacci
  def initialize(threads, number)
    @threads = Array.new(threads) { Thread.new {calculate number}}
    @threads.each(&:join)
  end

  #
  def calculate(number)
    return  number  if ( 0..1 ).include? number
    ( calculate( number - 1 ) + calculate( number - 2 ) )
  end
end

Fibonacci.new 4, 35

