alphabet = ('a'..'z').to_a

arr_vowels = %w(  a e i o u y)
hash = {}

alphabet.each.with_index(1) do |value,i|
  if arr_vowels.include?(value)
    hash[value] = i
  end
end

puts hash
