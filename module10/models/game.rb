require './models/card'
require './models/hand'
require './models/player'

class Game
  attr_reader :players, :hand
  
  def initialize
    @players = []
    @hand = Hand.new
  end
  
  def add_player(player)
    return if player_exists?(player) && @players.count > 0
    return "Cannot have more than 2 players" if @players.count > 2
    @players << player
  end
  
  def deal_cards(player)
    @hand.deal_cards(player)
  end
  
  def player_score(player)
    player.score
  end
  

  
  private 
  
  def player_exists?(player)
    @players.any? {|obj| obj.type == player.type}
  end
  
  def enough_players?
    @players.count == 2
  end
  
  def not_enough_players?
     !enough_players?
  end
end