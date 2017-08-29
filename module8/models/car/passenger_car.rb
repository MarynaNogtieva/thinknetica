require './models/car/car'

# Для пассажирских вагонов:
# Добавить атрибут общего кол-ва мест (задается при создании вагона)
# Добавить метод, который "занимает места" в вагоне (по одному за раз)
# Добавить метод, который возвращает кол-во занятых мест в вагоне
# Добавить метод, возвращающий кол-во свободных мест в вагоне.

class PassengerCar < Car
  attr_reader :seats_number, :taken_space

  def initialize(number, seats_number)
    super(number)
    @seats_number = seats_number
    @taken_space = 0
  end

  def take_seat
    @taken_space += 1 if @taken_space < @seats_number
  end

  def available_seats
    @seats_number - @taken_space
  end

  def to_s
    "Type: Passenger, number: #{number} , seats: #{seats_number}"
  end
end
