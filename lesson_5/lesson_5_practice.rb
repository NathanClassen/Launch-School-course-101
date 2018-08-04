# Lesson 5 Practice Problems: Sorting, Nested Collections 
#   and Working with Blocks


#Practice Problem 1
###################################################################

arr = ['10', '11', '9', '7', '8'].sort do |a, b|
  b.to_i <=> a.to_i
end

p arr

#Practice Problem 2
###################################################################

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

books.sort_by do |hash|
  hash[:published]
end

#Practice Problem 3
###################################################################

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]

arr3 = [['abc'], ['def'], {third: ['ghi']}]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}

puts arr1[2][1][3]
puts arr2[1][:third][0]
puts arr3[2][:third][0][0]
puts hsh1['b'][1]
puts hsh2[:third].key(0)

#Practice Problem 4
###################################################################

arr1 = [1, [2, 3], 4]

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]

hsh1 = {first: [1, 2, [3]]}

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}

arr1[1][1]            = 4
arr2[2]               = 4
hsh1[:first][2][0]    = 4
hsh2[['a']][:a][2]    = 4

p arr1
p arr2
p hsh1
p hsh2

#Practice Problem 5
###################################################################

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

ages = munsters.each_with_object([]) do |(k, v), arr|
         if v['gender'] == 'male' then arr << v['age'] end
       end.sum

ages

#Practice Problem 6
###################################################################

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |(k, v)|
  puts " #{k} is a #{v['age']} year-old #{v['gender']}."
end

#Practice Problem 7
###################################################################

# var a is assigned the value of 2
# var b is assigned the value of an array containing elements 5 
#    and 8

# var arr is an array with a first element of the value that a is 
#     pointing at and a second element of the value that b is 
#     pointing at.

# arr's first value is incremented by two, arr[0] is no longer 
#  pointing at the same value as var a. 
# arr's second element is an array, that arrays first element is 
#  decremented by the val that var a is pointing at which is 2, so
# var a = 2 var b = [3, 8]

#Practice Problem 8
###################################################################

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |k, v|
  v.join.chars.each do |char|
    if %w(a e i o u).include? char
      puts char
    end
  end
end

#Practice Problem 9
###################################################################

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map do |arr|
  arr.sort {|a, b| b <=> a}
end

#Practice Problem 10
###################################################################

arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

arr.map do |hash|
  hsh = {}
  hash.each do |k, v|
    hsh[k] = v += 1
  end
  hsh
end

#Practice Problem 11
###################################################################

arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

arr.map do |arr|
  arr.select do |num|
    num % 3 == 0
  end
end

#Practice Problem 12
###################################################################

arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

arr.each_with_object({}) do |arr, hash|
  hash[arr[0]] = arr[1]
end

#Practice Problem 13
###################################################################

arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

arr.sort_by do |arr|
  arr.reject {|num| num % 2 == 0}
end


#Practice Problem 14
###################################################################

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}


hsh.each_with_object([]) do |(k, v), array|
  if v[:type] == 'fruit'
    array << v[:colors].map {|color| color.capitalize}
  else
    array << v[:size].upcase
  end
end

#Practice Problem 15
###################################################################

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]


arr.select do |hash|
  hash.all? do |k, v|
    v.all? {|i| i.even?}
  end
end

#Practice Problem 16
###################################################################

def gen_UUID
  chars = []
  (0..9).each{ |i| chars << i.to_s}
  ('a'..'f').each{ |e| chars << e.to_s}

  uuid = ""
  sections = [8, 4, 4, 4, 12]
  sections.each_with_index do |sec, indx|
    sec.times {uuid << chars.sample}
    uuid << '-' unless indx >= 4
  end
  uuid
  puts uuid
end
gen_UUID


# had to look at example










