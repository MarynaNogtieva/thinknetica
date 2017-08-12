=begin
6. Сумма покупок. Пользователь вводит поочередно название товара,
 цену за единицу и кол-во купленного товара (может быть нецелым числом).
 Пользователь может ввести произвольное кол-во товаров до тех пор,
  пока не введет "стоп" в качестве названия товара. На основе введенных данных
   требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия
товаров, а значением - вложенный хеш, содержащий цену за единицу товара
и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

def get_name
  puts "What is the item called?"
  name = gets.chomp
  name
end

def get_cost
  puts "How much does it cost?"
  price_per_item = gets.chomp.to_f
  price_per_item
end

def get_amount
  puts "How many did you buy?"
  amount = gets.chomp.to_f
  amount
end

def add_item (items)
  name = get_name
  price_per_item = get_cost
  amount = get_amount

  items[name.to_sym]={price: price_per_item, amount: amount}
  items
end


def total_item_cost(one_item)
  amount = one_item[:amount]
  price = one_item[:price]
  return (price * amount).round(2)
end

def display_items_cost(items)
  total_amount = 0
  items.each do |name,item|
     item_cost = total_item_cost(item)
     total_amount += item_cost
     puts "#{name}: $#{item_cost} "
  end
  puts "total_amount: $#{total_amount.round(2)}"
end



items = {}
loop do

puts "Enter your choice"
puts "add: to add item"
puts "stop: to exit"

choice = gets.chomp.downcase
 case choice
   when 'add'

     add_item(items)
   when 'stop'
       puts items
     display_items_cost(items)
     break
 end
end
