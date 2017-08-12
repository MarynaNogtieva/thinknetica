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

fibanacci = [0,1]

total_result = 0

while (num = fibanacci[-1] + fibanacci[-2]) < 100 do
  fibanacci.push(num)
end

puts fibanacci
