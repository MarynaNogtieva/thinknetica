print "Enter height: "
h = gets.to_f
  if h <=0
    print "height cannot be less or equal to 0, setting height to 1 \n"
    h = 1
  end
print "Enter base: "
b =gets.to_f

if b <=0
  print "base cannot be less or equal to 0, setting base to 1 \n"
  b = 1
end


area = 1.0 / 2 * h * b
puts "b: #{b}, h: #{h}"
puts "the triangle's area is #{area}"
