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


class Train

attr_accessor :number, :type, :car_amount, :speed

  def initialize(number,type,car_amount)
    @number = number
    @type = type
    @car_amount = car_amount
    @speed = 0
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

  def car_amount
    car_amount
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
end
