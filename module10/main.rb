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
    @temporary_turns = @game.players
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
    @game.deal_cards(player, count)
    show_cards(player)
    Printer.show_bank(@game.bank_amount)
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
     @game.hit(player)
     show_cards(player)
  end
  
  def stay(player)
    @game.stay(player)
    show_cards(player)
    show_player_score(player)
    
    @temporary_turns.delete_if { |obj| obj.type == player.type }
    if @temporary_turns.count > 0
      @turns = @temporary_turns.cycle 
    else
      see_result
    end
  end
  
  def see_result
    dealer_score = 0
    player_score = 0
    @game.players.each do |player|
      show_player_score(player)
      if player.type == :player
         player_score = @game.player_score(player)
       else
         dealer_score = @game.player_score(player)
       end
    end
    define_winner(dealer_score, player_score)
    
    finish
  end
  
  def define_winner(dealer_score, player_score)
    if @game.winner?(player_score)
      puts "Dealer busts! Player wins"
    elsif @game.winner?(dealer_score)
      puts "Player busts! Dealer wins"
    else
      if player_score > dealer_score || player_score <= 21
        puts "player wins"
      elsif player_score == dealer_score
        puts "player and dealer tied"
      elsif dealer_score > player_score || dealer_score <= 21
        puts "dealer wins"
      end
    end
  end
  
  def finish
    puts 'Game over!'
    @game = Game.new
    @turns = []
    @game_over = true
  end
end

m = Main.new
m.load_basic_menu