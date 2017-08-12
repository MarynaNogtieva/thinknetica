=begin

 Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
 Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.
 (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
  Алгоритм опредления високосного года: www.adm.yar.ru
=end

def user_input (word)
  num = 0
  if word == 'day'
    puts "Enter day: "
    num = gets.chomp.to_i
  elsif word == 'month'
    puts "Enter moth: "
    num = gets.chomp.to_i
  else
    puts "Enter year "
    num = gets.chomp.to_i
  end
  num
end

day = user_input 'day'
month = user_input 'month'
year = user_input 'year'

def leap?(year)
   (year % 4 == 0 || year % 400 == 0) && year % 100 != 0
end

days_in_month_arr = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if leap?(year)
  days_in_month_arr[1] = 29
end

days_from_beginning = 0
count = 0

if month > 1
  while count < month-1 do
    days_from_beginning += days_in_month_arr[count]
    count += 1
  end
  days_from_beginning += day
else
  days_from_beginning = day
end

puts  " #{days_from_beginning} days have passed from the beginning of the year."
