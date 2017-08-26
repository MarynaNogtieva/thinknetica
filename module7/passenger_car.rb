require './car'
=begin
Для пассажирских вагонов:
Добавить атрибут общего кол-ва мест (задается при создании вагона)
Добавить метод, который "занимает места" в вагоне (по одному за раз)
Добавить метод, который возвращает кол-во занятых мест в вагоне
Добавить метод, возвращающий кол-во свободных мест в вагоне.
=end
class PassengerCar < Car
  attr_reader :type, :seats_number, :seats_taken
  def initialize(number,seats_number)
    super(number)
    @type = "Passenger"
    @seats_number = seats_number
    @seats_taken = 0
  end

  def take_seat
    @seats_taken += 1 if @seats_taken <= @seats_number
  end

  def available_seats
    @seats_number - @seats_taken
  end

end
