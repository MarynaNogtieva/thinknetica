=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции)
=end
require './instance_counter'
class Station
  include InstanceCounter
  attr_reader :trains, :name
  attr_accessor :stations
  @stations = []
  def initialize(name)
    @name = name
    @trains = []
    self.class.stations << self
    register_instance
  end

  class << self
    def all
      @stations
    end
  end

  def add_train(train)
    trains << train
  end

  def trains_by_type(type)
    trains.select {|train|  train.type == type}
  end

  def delete_train(train)
    trains.delete(train)
  end
end
