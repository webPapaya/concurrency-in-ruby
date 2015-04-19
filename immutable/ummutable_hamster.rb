require "hamster/vector"

vector_original     = Hamster.vector 1, 2, 3
vector_transformed  = vector_original.push 4

puts vector_original.length # 3
puts vector_transformed.length # 4
puts vector_transformed.object_id == vector_original.object_id # false

