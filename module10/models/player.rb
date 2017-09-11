
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
end