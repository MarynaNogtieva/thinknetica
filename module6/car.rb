require './manufacturer'
require './instance_counter'
require './validate_number'
class Car
  attr_reader :number
  include InstanceCounter
  include Manufacturer
  include ValidateNumber
  def initialize(number)
    @number = number
    register_instance
    validate_number!
  end
end
