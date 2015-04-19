require 'thread'

Queue
$counter = 0
mutex = Mutex.new

100.times.map do
  Thread.new do
    100.times do
      mutex.lock
      counter = $counter + 1
      sleep 0.001
      $counter = counter
      mutex.unlock
    end
  end
end.each(&:join)

puts $counter

