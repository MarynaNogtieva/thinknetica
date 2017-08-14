class Car
  attr_accessor :speed
  attr_reader :engine_volume

  def initialize(speed = 0,engine_volume = 2.0)
    @speed = speed
    @engine_volume = engine_volume
  end

  def start_engine
    puts "Woom!"
  end

  def beep
    puts "beep beep"
  end

  def stop
    #call setter method
    self.speed = 0
  end

  def go
    self.speed = 50
  end
end
