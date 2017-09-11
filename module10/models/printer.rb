

class Printer 
  
  def create_player
    print "Enter player name: "
    name = gets.chomp
    type = player_type
  end

  def player_type
    print "Enter player type: dealer or player"
    type = gets.chomp.downcase
    
    while  not_valid_player_type?(type) do
    print 'Wrong type, try again'
    type = gets.chomp.downcase
    end
    
    type.to_sym
  end
  
  def valid_player_type?(type)
    type == 'dealer' || type == 'player'
  end
  
  def not_valid_player_type?(type)
    !valid_player_type?(type)
  end
  
end