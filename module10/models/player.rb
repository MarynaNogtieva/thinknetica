
class Player
  attr_reader :name, :type, :currency, :cards, :score
  attr_accessor :money_in_bank
  
  #type is going to be a sympol :dealer or :player
  def initialize(name:, type:)
    @name = name
    @type = type
    @money_in_bank = 100
    @currency = :usd
    @cards = []
    @score = 0
  end
  
  def add_score(number)
    @score += number
  end
  
end