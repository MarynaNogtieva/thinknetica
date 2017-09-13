require './models/card'
class CardDeck
  
  SUITS = %w(♠ ♣ ♥ ♦)
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
  
  attr_reader :cards
  
  def initialize
    @cards = []
    SUITS.each do |type|
      VALUES.each do |value|
        @cards << Card.new(type, value)
      end
    end
    @cards.shuffle!
    nil
  end
  
  def remaining
    @cards.count
  end
  
end