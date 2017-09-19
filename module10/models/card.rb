class Card
  LETTER_VALUES = { J: 10, Q: 10, K: 10, A: 11 }
  attr_reader :type, :value, :points
  
  def initialize(type, value)
    @type = type
    @value = value
    @points = assign_card_points
  end
  
  def to_s
    "#{@value} of #{@type}"
  end
  
  def assign_card_points
    cost = LETTER_VALUES.fetch(@value.to_s.to_sym, @value.to_i)
    cost  
  end
end