print "What is your name? "
name = gets.chomp.capitalize!
print "What is your height in cm? "
height = gets.to_i
ideal_weight = height - 110

if ideal_weight >=0
  puts "Dear #{name}, your ideal weight is #{ideal_weight}"
else
  puts "Dear #{name}, your weight is optimal"
end
