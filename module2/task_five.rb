=begin

 Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
 Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.
 (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
  Алгоритм опредления високосного года: www.adm.yar.ru
=end

def user_input
  puts "Enter day: "
  day = gets.chomp.to_i

  puts "Enter moth: "
  month = gets.chomp.to_i

  puts "Enter year "
  year = gets.chomp.to_i

  return [day,month,year]
end

date_arr = user_input

day = date_arr[0]
month = date_arr[1]
year = date_arr[2]

def is_leap?(year)
  return year % 4 == 0 && year % 400 == 0 && year % 100 != 0
end

days_in_month_arr = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if is_leap?(year)
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
