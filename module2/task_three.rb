 #Заполнить массив числами фибоначчи до 100
=begin
The Fibonacci Sequence is the series of numbers:

0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...

The next number is found by adding up the two numbers before it.

The 2 is found by adding the two numbers before it (1+1)
The 3 is found by adding the two numbers before it (1+2),
And the 5 is (2+3),
and so on!
=end

my_array = [0,1,1]

total_result = 0

while total_result < 100  do
  total_result = my_array[-1] + my_array[-2]
  #if I don't break it will print 144
  break if total_result >100
  my_array.push(total_result)
end

puts my_array
