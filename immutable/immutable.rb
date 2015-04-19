array = [1,2,3].freeze
array.push 4 # can't modify frozen Array (RuntimeError)
