require './car'

class PassengerCar < Car
  attr_reader :car_type
  def initialize(number)
    super(number)
    @car_type = "Passenger"
  end
end
