class Card
  attr_reader :type, :value
  
  def initialize(type, value)
    @type = type,
    @value = value
  end
  
  def to_s
    "#{@value} of #{@type}"
  end
end