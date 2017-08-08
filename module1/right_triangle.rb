print "Enter side a: "
a = gets.to_f

print "Enter side b: "
b = gets.to_f

print "Enter side c: "
c = gets.to_f


longest_side = 0
side_1 = 0
side_2 = 0
#find longest side
if (b > c && b > a) || (b >= c && b > a) || (b > c && b >= a) || (b >= c && b >= a)
  longest_side = b
  side_1 = a
  side_2 = c
elsif (c > b && c > a) || (c >= b && c >a) || (c > b && c >= a) || (c >= b && c >=a)
  longest_side = c
  side_1 = a
  side_2 = b
else
  longest_side = a
  side_1 = b
  side_2 = c
end
#check if it's right triangle and if it's an isosceles triangle
triangle_is_right = side_1 ** 2 + side_2 ** 2== longest_side ** 2
if (triangle_is_right) && (side_1 == side_2)
  puts "this is both right and isosceles triangle"
  puts "side_1 is #{side_1}"
  puts "side_2 is #{side_2}"
  puts "longest_side is #{longest_side}"
elsif (!triangle_is_right) && (side_1 == side_2)
  puts "this is an isosceles triangle only"
  puts "side_1 is #{side_1}"
  puts "side_2 is #{side_2}"
  puts "longest_side is #{longest_side}"
elsif ((side_1 ** 2) + (side_2 ** 2)) == longest_side ** 2
  puts "this is  right  triangle"
  puts "side_1 is #{side_1}"
  puts "side_2 is #{side_2}"
  puts "longest_side is #{longest_side}"
elsif longest_side == side_2 && longest_side == side_1
  puts "this is an isosceles triangle, all sides are equal"
  puts "side_1 is #{side_1}"
  puts "side_2 is #{side_2}"
  puts "longest_side is #{longest_side}"
else
  puts "this is neither right nor isosceles triangle"
  puts "side_1 is #{side_1}"
  puts "side_2 is #{side_2}"
  puts "longest_side is #{longest_side}"
end
