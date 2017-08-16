require './car'

class PassengerCar < Car
  def initialize(number)
    super(number)
    @car_type = "Passenger"
  end
end
