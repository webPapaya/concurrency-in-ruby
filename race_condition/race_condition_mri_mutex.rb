# This is the solution to the problem from
# example race_condition_mri.rb. This uses
# a mutex so that only one thread can run
# the code between mutex.lock and mutex.unlock
# at any given time. Because of that the race
# condition is gone.

require 'thread'

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

