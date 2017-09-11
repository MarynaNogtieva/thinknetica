
class Player
  attr_reader :name, :type, :currency, :cards
  attr_accessor :money_in_bank
  
  #type is going to be a sympol :dealer or :player
  def initialize(name:, type:)
    @name = name
    @type = type
    @money_in_bank = 100
    @currency = :usd
    @cards = []

  end  
  
  def bet_money(amount)
    return if @money_in_bank < amount
    @money_in_bank -= amount 
  end
end