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
# require './station'
# require './route'
# require './car'


class Train
  attr_reader :number, :type, :speed, :route, :station_index, :carriagies

  def initialize(number)
    @number = number
    @carriagies = []
    @speed = 0
  end

  def speed_up(speed)
    @speed += speed
    @speed = 0 if speed < 0
  end

  def stop
    @speed = 0
  end

  def stopped?
    speed == 0
  end

  def attach_car(car)
    return "Cannot attach car. Train is still moving" unless stopped?
    @carriagies << car
  end

  def dettach_car(car)
    return "Cannot dettach car. Train is still moving" unless stopped?
    return "There are no cars left. " if carriagies.empty?
    @carriagies.delete(car)
    "car is dettached"
  end

  def set_route(route)
    return "you have to create route first" if route.nil?
    @route = route
    @station_index = 0
  end

  def move_forward
    current_station.delete_train(self)
    @station_index += 1 if station_index < route.stations_list.size - 1
    current_station.add_train(self)
  end

  def move_backwards
    current_station.delete_train(self)
    @station_index -= 1 if station_index > 0
    current_station.add_train(self)
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

  private
  #this method is used only inside this class, therefore, it should not be disclosed to others
  def show_station_by_index(index)
     return nil if index < 0
     route.stations_list[index]
  end

end
