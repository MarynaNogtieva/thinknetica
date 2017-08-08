puts "enter a: "
a = gets.to_f

puts "enter b: "
b = gets.to_f

puts "enter c: "
c = gets.to_f

d = (b**2 - 4 * a * c)
x1 = 0
x2 = 0


if d > 0
  x1 = (-b + Math.sqrt(d)) / 2.0 * a
  x2 = (-b - Math.sqrt(d)) / 2.0 * a

  puts "D is #{d}"
  puts "x1 is #{x1}"
  puts "x2 is #{x2}"
elsif d = 0
  x1 = -b / (2.0 * a)
  puts "D is #{d}"
  puts "x1 = x2 =  #{x1}"
else
  puts "D is #{d}, no square root"
end
