require './car'

class PassengerCar < Car
  attr_reader :type
  def initialize(number)
    super(number)
    @car_type = "Passenger"
  end
end
