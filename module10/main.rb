require './models/card'
require './models/card_deck'
require './models/player'
require './models/hand'
require './models/game'
require './models/printer'

class Main
  
  
  def initialize
  # initialize game => hand => card_deck
   @game = Game.new
   @turns = []
  end
  # start Game

  def start_game
    Printer.game_greeting
    
    loop do
      Printer.show_base_actions
      user_choice = gets.chomp.downcase
      break if user_choice == 'q'
      #if n - create player - assign card, push player to turns array
    end
  end
  
end