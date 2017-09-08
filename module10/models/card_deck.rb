require './card'
class CardDeck
  SUITS = %w(♠, ♣, ♥, ♦)
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
  
  attr_reader :card_deck
  
  def initialize
    @card_deck = []
    SUITS.each do |type|
      VALUES.each do |value|
        @card_deck << new Card(type, value)
      end
    end
  end
  
end