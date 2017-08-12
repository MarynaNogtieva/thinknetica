=begin

 Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
 Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.
 (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
  Алгоритм опредления високосного года: www.adm.yar.ru
=end

def user_input (word)
  puts "Enter #{word}"
  gets.chomp.to_i
end

day = user_input 'day'
month = user_input 'month'
year = user_input 'year'

def leap?(year)
   (year % 4 == 0 || year % 400 == 0) && year % 100 != 0
end

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if leap?(year)
  months[1] = 29
end

days = day


if month > 1
  months.each.with_index(1) do |m,i|
    days += m
    break if i < month
  end
end

puts  " #{days} days have passed from the beginning of the year."
