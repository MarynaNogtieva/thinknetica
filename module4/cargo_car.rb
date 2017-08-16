require './car'

class CargoCar < Car

  def initialize(number)
    super(number)
    @car_type = "Cargo"
  end
end
