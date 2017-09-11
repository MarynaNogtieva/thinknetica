require './models/card_deck'
class Hand
  WIN_SCRORE = 21
  DEFAULT_BET = 10
  
  attr_reader :cards
  
  def initialize
    @cards = CardDeck.new().cards
  end
  
  def deal_cards(player, count = 2)
    dealt_cards =  @cards.sample(count)
    dealt_cards.each do |card|
      player.cards << card
      @cards.delete(card)
    end
  end
  
  def total_score(cards)
    total_score = 0
    ace_count = 0
    
    cards.each do |card|
      ace_count += 1 if card.value == 'A'
      total_score += card.points
      total_score -=10 if ace_count > 0 && total_score > 21
    end
  end  
end