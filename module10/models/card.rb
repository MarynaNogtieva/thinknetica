class Card
  attr_reader :type, :value, :points
  
  def initialize(type, value)
    @type = type,
    @value = value,
    @points = assign_card_points(value)
  end
  
  def to_s
    "#{@value} of #{@type}"
  end
  
  def assign_card_points(value)
    cost = 0
    if(value == 'J' || value == 'Q' || value == 'K' || value == 'A')
      hash_points = {J: 10, Q: 10, K: 10, A: 11}
      cost = hash_points[value.to_sym]
    else
      cost = value.to_i
    end
    cost  
  end
end