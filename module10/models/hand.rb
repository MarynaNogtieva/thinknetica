require './models/card_deck'
class Hand
  WIN_SCORE = 21
  DEFAULT_BET = 10
  
  attr_reader :cards, :bank
  
  def initialize
    @cards = CardDeck.new().cards
    @bank = 0
  end
  
  def deal_cards(player, count = 2)
    dealt_cards =  @cards.sample(count)
    dealt_cards.each do |card|
      player.cards << card
      @cards.delete(card)
    end
      make_bet!(player)
  end
  
  def total_score(cards)
    total_score = 0
    ace_count = 0
    
    cards.each do |card|
      ace_count += 1 if card.value == 'A'
      total_score += card.points
      total_score -=10 if ace_count > 0 && total_score > WIN_SCORE
    end
    total_score
  end
  
  def make_bet!(player)
    player.bet_money(DEFAULT_BET)
    @bank += DEFAULT_BET
  end 
  
  #make sure to add only if score is < WIN_SCORE and cards amount is < 3
  def hit(player)
    deal_cards(player, 1)
  end 
  
  def stay(player)
    total_score(player.cards);
  end
  
  def open_cards(cards)
    total_score(cards)
  end
  
  def empty_hand(player)
    player.cards.clear
  end
  
  def winner?(score)
    WIN_SCORE == score
  end
  
  def is_winner(dealer_score, player_score)
    if winner?(player_score)
      Printer.print_win_message('Dealer busts! Player wins')
    elsif winner?(dealer_score)
      Printer.print_win_message('Player busts! Dealer wins')
    else
      if player_wins?(player_score, dealer_score)
        Printer.print_win_message('player wins')
      elsif player_score == dealer_score
        Printer.print_win_message('player and dealer tied')
      elsif dealer_wins?(player_score, dealer_score)
        Printer.print_win_message('dealer wins')
      end
    end
  end
  
  private
  
  def player_wins?(player_score, dealer_score)
    (player_score > dealer_score && player_score <= WIN_SCORE) || (player_score < dealer_score && dealer_score > WIN_SCORE)
  end
  
  def dealer_wins?(player_score, dealer_score)
    (dealer_score > player_score && dealer_score <= WIN_SCORE) || (dealer_score < player_score && player_score > WIN_SCORE)
  end
  
end