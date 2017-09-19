class Game
  
  DEFAULT_BET = 10
  WIN_SCORE = 21
  
  attr_reader :players, :cards, :bank
  
  def initialize
    @players = []
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
    
  def add_player(player)
    raise 'Player already exists' if player_exists?(player) 
    raise 'Cannot have more than 2 players' if @players.count > 2
    @players << player
  end
  
  def is_winner(dealer_score, player_score)
    
    if winner?(player_score)
      Printer.print_message('Dealer busts! Player wins')
    elsif winner?(dealer_score)
      Printer.print_message('Player busts! Dealer wins')
    else
      if player_wins?(player_score, dealer_score)
        Printer.print_message('player wins')
      elsif player_score == dealer_score
        Printer.print_message('player and dealer tied')
      elsif dealer_wins?(player_score, dealer_score)
        Printer.print_message('dealer wins')
      end
    end
  end
  

  private 
  
  def make_bet!(player)
    player.bet_money(DEFAULT_BET)
    @bank += DEFAULT_BET
  end 
  
  def player_exists?(player)
    @players.any? {|obj| obj.type == player.type}
  end
  
  def enough_players?
    @players.count == 2
  end
  
  def not_enough_players?
     !enough_players?
  end
  
  def player_wins?(player_score, dealer_score)
    (player_score > dealer_score && player_score <= WIN_SCORE) || (player_score < dealer_score && dealer_score > WIN_SCORE)
  end
  
  def dealer_wins?(player_score, dealer_score)
    (dealer_score > player_score && dealer_score <= WIN_SCORE) || (dealer_score < player_score && player_score > WIN_SCORE)
  end
  
  def winner?(score)
    WIN_SCORE == score
  end
  
end