alphabet = ('a'..'z').to_a

hash = {}

alphabet.each_index do |i|
  if ['a','e','i','o','u','y'].include?(alphabet[i])
    key = alphabet[i]
    hash[key] = i+1
  end
end

puts hash
