require './models/card_deck'

class Hand
  attr_reader :cards
  
  def initialize
    @cards = CardDeck.new().cards
  end
  
end