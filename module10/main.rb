require './models/card'
require './models/card_deck'
require './models/player'
require './models/hand'
require './models/game'
require './models/printer'

class Main
  DEALERS = ['Sedilia', 'Foliophagous', 'Scorpion', 'Basilisk', 'Cryptoclidus', 'Panther']
  
  def initialize
   @hand = Hand.new
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
  
  private 
  
  def start_game
    @players_queue = @game.players
    @game_over = false
    player = create_player
    dealer = create_dealer

    @turns = @game.players.cycle
    deal_cards(player, 2)
    deal_cards(dealer, 2)
    define_turns
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
    @hand.deal_cards(player, count)
    Printer.show_cards(player)
    Printer.show_bank(@hand.bank)
  end
  
  
  def show_player_score(player)
    player_score = @hand.total_score(player.cards)
    Printer.show_score(player, player_score)
    player_score
  end
  
  def define_turns
    loop do
      break if @game_over 
      player = @turns.next
      player_action(player)
    end
  end
  
  def player_action(player)
    if player.cards.count == 3
      see_result
      return
    end
    
    Printer.show_choice(player)
    choice = gets.to_i
    case choice
     when 1 then hit(player)
     when 2 then stay(player)
     when 3 then see_result
     when 0 then @game_over = true
    end
  end
    
  def hit(player)
     @hand.hit(player)
     Printer.show_cards(player)
  end
  
  def stay(player)
    @hand.stay(player)
    Printer.show_cards(player)
    show_player_score(player)
    
    @players_queue.delete_if { |obj| obj.type == player.type }
    if @players_queue.count > 0
      @turns = @players_queue.cycle 
    else
      see_result
    end
  end
  
  def see_result
    dealer_score = 0
    player_score = 0
     player_score, dealer_score = @game.players.map do |player|
      show_player_score(player)
     end
    
    define_winner(dealer_score, player_score)
    
    finish
  end
  
  def define_winner(dealer_score, player_score)
    @hand.is_winner(dealer_score, player_score)
  end
  
  def finish
    puts 'Game over!'
    @hand = Hand.new
    @game = Game.new
    @turns = []
    @game_over = true
  end
end

m = Main.new
m.load_basic_menu