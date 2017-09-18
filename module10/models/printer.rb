# QUESTION: require 'colorize'
require './models/player'

class Printer 
  
  #this method will be moved to some other class

    
  def self.player_name
    print 'Enter player name: '
    name = gets.chomp
    name
  end
  
  def self.player_type
    print 'Enter player type: dealer or player'
    type = gets.chomp.downcase
    
    while  not_valid_player_type?(type) do
    print 'Wrong type, try again'
    type = gets.chomp.downcase
    end
    
    type.to_sym
  end
  
  def self.show_base_actions
    puts 'Enter n - to start a new game'
    puts 'Enter q - to quit game'
  end

  def self.show_player_choice
    puts 'Choose action: '
    puts '1. if you want to hit'
    puts '2. if you want to pass'
    puts '3. if you want to open the cards'
    puts '0. if you want to exit'
  end
  
  def self.show_dealer_choice
    puts 'Choose action: '
    puts '1. if you want to hit'
    puts '2. you want to skip'
    puts '0. if you want to exit'
  end
  
  def self.show_score(player, score)
    puts "#{player.type} - #{player.name}: #{score}"
  end
  
  def self.show_bank(bank_money)
    puts "Money in the bank: #{bank_money}"
  end
  
  def self.game_greeting
    puts 'Welcome to our game! We will start now!'
  end
  
  
  private 
  
  def valid_player_type?(type)
    type == 'dealer' || type == 'player'
  end
  
  def not_valid_player_type?(type)
    !valid_player_type?(type)
  end
  
end