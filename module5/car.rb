require './manufacturer'

class Car
  attr_reader :number
  include Manufacturer
  def initialize(number)
    @number = number
  end
end
