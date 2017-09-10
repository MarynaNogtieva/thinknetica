require './models/card_deck'

class Hand
  attr_reader :cards
  
  def initialize
    @cards = CardDeck.new().cards
  end
  
  def deal_cards(count = 2)
    dealt_cards =  @cards.sample(2)
    dealt_cards.each do |card|
      @cards.delete(card)
    end
    dealt_cards
  end
end