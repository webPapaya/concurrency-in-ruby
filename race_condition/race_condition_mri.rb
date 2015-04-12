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

