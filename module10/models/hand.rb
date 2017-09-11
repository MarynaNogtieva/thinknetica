require './models/card_deck'
class Hand
  attr_reader :cards
  
  def initialize
    @cards = CardDeck.new().cards
  end
  
  def deal_cards(player, count = 2)
    dealt_cards =  @cards.sample(count)
    dealt_cards.each do |card|
      player.cards << card
      player.add_score(card.points)
      @cards.delete(card)
    end
  end  
end