require './models/card'
require './models/card_deck'
require './models/player'
require './models/hand'
require './models/game'
require './models/printer'

class Main
  DEALERS = ['Sedilia', 'Foliophagous', 'Scorpion', 'Basilisk', 'Cryptoclidus', 'Panther']
  
  def initialize
  # initialize game => hand => card_deck
   @game = Game.new
   @turns = []
  end
  # start Game

  def load_basic_menu
    Printer.game_greeting
    
    loop do
      Printer.show_base_actions
      user_choice = gets.chomp.downcase
      break if user_choice == 'q'
      start_game if user_choice == 'n'
      #if n - create player - assign card, push player to turns array
    end
  end
  
  def start_game
    player = create_player
    dealer = create_dealer
    puts @turns.inspect
  end
  
  def create_player
    name = Printer.player_name
    player = Player.new(name: name, type: :player)
    @game.add_player(player)
    @turns << player if @turns.count < 2
    player
  end
  
  def create_dealer
    name = DEALERS.sample
    dealer = Player.new(name: name, type: :dealer)
    @game.add_player(dealer)
    @turns << dealer if @turns.count < 2
    dealer
  end
  
end