
require './module/manufacturer'
require './module/instance_counter'
require './module/validation'

class Car
  attr_reader :number

  include InstanceCounter
  include Manufacturer
  include Validation

 validate :number, :presence

  def initialize(number)
    @number = number
    validate!
    validate_number!
    register_instance
  end

  protected

  def validate_number!
    raise 'Number must be a positive number and greater than 0' if number < 1
  end
end
