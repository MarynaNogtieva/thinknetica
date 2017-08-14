=begin
Класс Train (Поезд):
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route).
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

require './route'
class Train

attr_accessor :number, :type, :car_amount, :speed, :route, :station_index

  def initialize(number,type,car_amount)
    @number = number
    @type = type
    @car_amount = car_amount
    @speed = 0
    @route = nil
    @station_index = nil
  end

  def speed_up(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def current_speed
    puts "Current speed: #{speed}"
  end


  def stopped?
    speed == 0
  end

  def attach_car
    self.car_amount += 1 if stopped?
  end

  def dettach_car
    self.car_amount -= 1 if stopped? && car_amount > 0
  end

  def set_route(route)
    self.route = route
    self.station_index = 0
  end

  def move_forward
    self.station_index += 1
    move_by_station(station_index)
    show_route_info(station_index)
  end

  def move_backwards
    self.station_index -= 1 if station_index > 0
    move_by_station(station_index)
    show_route_info(station_index)
  end

  def move_by_station(index)
     route.stations_list[index]
  end

  def show_route_info(index)
    puts "Current station #{route.stations_list[index]}"
    puts "Previous station #{route.stations_list[index-1]}" if index > 0
    puts "Next station #{route.stations_list[index+1]}" if (index + 1 ) < (route.stations_list.length)
  end
end
