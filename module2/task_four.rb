alphabet = ('a'..'z').to_a

arr_vowels = %w( a e i o u y)
hash = {}

alphabet.each.with_index(0  ) do |value,i|
  if arr_vowels.include?(alphabet[i])
    key = alphabet[i]
    hash[key] = i+1
  end
end

puts hash
