require './manufacturer'
require './instance_counter'
require './validate'

class Car
  attr_reader :number
  include InstanceCounter
  include Manufacturer
  include Validate

  def initialize(number)
    @number = number
    validate!
    register_instance
  end

  protected
  def validate!
    raise "Number cannot be nil" if number.nil?
    raise "Number must be a positive number and greater than 0" if number < 1
    true
  end
end
