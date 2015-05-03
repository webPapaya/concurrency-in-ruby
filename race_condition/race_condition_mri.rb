# This is one possibility to generate a race
# condition in ruby mri. Ruby MRI normally has
# a GIL which prevents Ruby from executing any
# code parallel. 
#
# In this example 100 threads will be spawned.
# All those threads increment the global variable
# by one. So the end result should be 10 000. 
# Because we have a blocking sleep call in this
# example the interpreter thinks that it can do a
# context switch. So another thread takes over.
# Because this example stores the incremented
# value in a local variable this variable gets
# overwritten by the other thread.
# So in most cases the end result won't be 10 000.

$counter = 0

100.times.map do
  Thread.new do
    100.times do
      counter = $counter + 1
      sleep 0.001
      $counter = counter
    end
  end
end.each(&:join)

puts $counter

