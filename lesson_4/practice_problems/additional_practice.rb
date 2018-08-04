# Practice problem 1

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flint_hash = flintstones.each_with_object({}) do |name, hash|
  hash[name] = flintstones.index(name)
end

puts flint_hash

################################################################

# Practice problem 2

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

age_total = ages.values.inject(:+)
################################################################

# Practice problem 3

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

ages.each {|name, age| if age > 100 then ages.delete name end}

puts ages
################################################################

#Practice problem 4

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

ages.values.min
################################################################

#Practice problem 5

flintstones = %w(Fred Barney Wilma Betty BemBam Pebbles)

flintstones.find_index {|name| name.start_with? 'Be'}
################################################################

# Practice problem 6

flintstones = %w(Fred Barney Wilma Betty BemBam Pebbles)
flintstones.map! {|name| name[0, 3]}

puts flintstones
################################################################

# Practice problem 7

letters = {}
statement.split('').each do |letter|
  if letter == ' ' then next end
  letters[letter] = statement.split('').count(letter)
  statement.split('').delete(letter)
end
################################################################

# Practice problem 8

# in the first problem, it will output 1 then 3 because
# upon reaching line 4 in the first iteration, it removes
# the element indexed at 0 effectively lowering all of the 
# other elements indeces by 1. Then it goes to p the element
# indexed at 1 which is now the element (3) formerly indexed
# at 2. After this, it again removes the element indexed at 0 
# lowering the other elements indeces by 1 again and there is
# no longer an index 2 so it ends, having only outputted 1 and 3

# the second problem will output 1 and 2 because upon reaching
# lin 4 after the first iteration it removes the element indexed 
# at 3, then on the next iteration it p the element at index 1, 
# and then removes the element indexed at 2, and now there are
# no more elements to be iterated over.
################################################################

# Practice problem 9
class String
  def fancify
    self.split(' ').map! {|word| word.capitalize}.join(' ')
  end
end
################################################################

# Practice problem 10

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |member, attributes|
  case attributes["age"]
  when (0..17)
    attributes[:age_group] = "kiddo"
  when (18..64)
    attributes[:age_group] = "adult"
  else
    attributes[:age_group] = "old - timer"
  end
end

















