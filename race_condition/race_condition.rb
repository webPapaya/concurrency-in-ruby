class Calculator
  attr_accessor :counter
  def initialize
    @counter = 0
  end
end

calculator = Calculator.new

threads = Array.new(2) do
  Thread.new do
    100000.times { calculator.counter += 1 }
  end
end
threads.each(&:join)

puts calculator.counter