require './models/card'
require './models/card_deck'
require './models/player'
require './models/hand'
require './models/game'
require './models/printer'

class Main
  DEALERS = ['Sedilia', 'Foliophagous', 'Scorpion', 'Basilisk', 'Cryptoclidus', 'Panther']
  
  def initialize
   @game = Game.new
   @turns = []
   @game_over = false
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
    deal_cards(player, 2)
    deal_cards(dealer, 2)
    
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
  
  def deal_cards(player, count = 2)
    @game.deal_cards(player, count)
    show_cards(player)
    
    @game.show_bank_amount
  end
  
  def show_cards(player)
    player.cards.each do |card|
      puts "You have: #{card}" if player.type == :player
      puts "Dealer card: *" if player.type == :dealer
    end
  end
  
  def show_player_score(player)
    player_score = @game.player_score(player)
    Printer.show_score(player, player_score)
  end
  
  def define_turns
    loop do
      break if @game_over
      player = @turns.next
      player.type == :player ? player_action(player) : dealer_action(player)
    end
  end
  
  def player_action(player)
    see_result if player.cards.count == 3
    Printer.show_player_choice
  end
  
  def dealer_action(dealer)
    see_result if dealer.cards.count == 3
    Printer.show_dealer_choice
  end
  
  def see_result
  end
end

m = Main.new
m.load_basic_menu