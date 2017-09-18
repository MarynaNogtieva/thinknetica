# QUESTION: require 'colorize'
require './models/player'

class Printer 
  
  #this method will be moved to some other class

    
  def self.player_name
    print 'Enter player name: '
    name = gets.chomp
    name
  end
    
  def self.show_base_actions
    puts 'Enter n - to start a new game'
    puts 'Enter q - to quit game'
  end
  


  
  def self.show_choice(player)
    player.type == :player ? player_choice : dealer_choice
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
  
  def self.show_cards(player)
    player.cards.each do |card|
      puts "You have: #{card}" if player.type == :player
      puts "Dealer card: *" if player.type == :dealer
    end
  end
  
  def self.print_win_message(msg)
    puts msg
  end
  
  private
    
  def self.player_choice
    puts 'Choose action: '
    puts '1. if you want to hit'
    puts '2. if you want to pass'
    puts '3. if you want to open the cards'
    puts '0. if you want to exit'
  end
  
  def self.dealer_choice
    puts 'Choose action: '
    puts '1. if you want to hit'
    puts '2. you want to skip'
    puts '0. if you want to exit'
  end
  
end