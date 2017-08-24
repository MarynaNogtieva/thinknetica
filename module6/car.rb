require './manufacturer'
require './instance_counter'
class Car
  attr_reader :number
  include InstanceCounter
  include Manufacturer
  def initialize(number)
    @number = number
    register_instance
  end
end
