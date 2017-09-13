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
    @turns = @game.players.cycle
    deal_cards(2)
    
  end
  
  def create_player
    name = Printer.player_name
    player = Player.new(name: name, type: :player)
    @game.add_player(player)
    player
  end
  
  def create_dealer
    name = DEALERS.sample
    dealer = Player.new(name: name, type: :dealer)
    @game.add_player(dealer)
    dealer
  end
  
  def deal_cards(count)
    @game.players.each do |player|
      @game.deal_cards(player, count)
      show_cards(player)
    end
    
    @game.show_bank_amount
  end
  
  def show_cards(player)
    player.cards.each do |card|
      puts "You have: #{card}" if player.type == :player
      puts "Dealer card: *" if player.type == :dealer
    end
  end
  
end

m = Main.new
m.load_basic_menu