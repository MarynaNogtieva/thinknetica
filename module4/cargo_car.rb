require './car'

class CargoCar < Car
  attr_reader :car_type
  def initialize(number)
    super(number)
    @car_type = "Cargo"
  end
end
