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
require './station'
require './route'


class Train
  attr_reader :number, :type, :car_amount, :speed, :route, :station_index

  def initialize(number, type, car_amount)
    @number = number
    @type = type
    @car_amount = car_amount
    @speed = 0
  end

  def speed_up(speed)
    self.speed += speed
    self.speed = 0 if speed < 0
  end

  def stop
    @speed = 0
  end

  def stopped?
    speed == 0
  end

  def attach_car
    @car_amount += 1 if stopped?
  end

  def dettach_car
    @car_amount -= 1 if stopped? && car_amount > 0
  end

  def set_route(route)
    @route = route
    @station_index = 0
  end

  def move_forward
    #remove train from previous station
    current_station.delete_train(self)
    @station_index += 1 if station_index < route.stations_list.size-1
    #add train to the new station
    current_station.add_train(self)
  end

  def move_backwards
    #remove train from previous station
    current_station.delete_train(self)
    @station_index -= 1 if station_index > 0
    #add train to the new station
    current_station.add_train(self)
  end

  def show_station_by_index(index)
     return nil if index < 0
     route.stations_list[index]
  end

  def current_station
    show_station_by_index station_index
  end

  def next_station
    show_station_by_index station_index + 1
  end

  def previous_station
    show_station_by_index station_index - 1
  end


end
