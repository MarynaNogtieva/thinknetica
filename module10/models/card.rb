class Card
  attr_reader :type, :value, :points
  
  def initialize(type, value)
    @type = type
    @value = value
    @points = assign_card_points(value)
  end
  
  def to_s
    "#{@value} of #{@type}"
  end
  
  def assign_card_points(value)
    cost = { J: 10, Q: 10, K: 10, A: 11 }.fetch(value.to_s.to_sym, value.to_i)
    cost  
  end
end