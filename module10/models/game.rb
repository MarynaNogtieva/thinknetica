require './models/card'
require './models/hand'

class Game
  attr_reader :players, :hand
  
  WIN_SCRORE = 21
  DEFAULT_BET = 10
  
  def initialize
    @players = []
    @hand = Hand.new
  end
  
  def add_player(player)
    return if player_exists?(player) && @players.count > 0
    return "Cannot have more than 2 players" if @players.count > 0
    @players << player
  end
  
  private 
  def player_exists(player)
    @players.any? {|obj| obj.type = player.type}
  end
end