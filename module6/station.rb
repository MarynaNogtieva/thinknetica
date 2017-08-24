=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции)
=end
require './instance_counter'
require './validate'

class Station
  include InstanceCounter
  include Validate

  attr_reader :trains, :name

  @@stations = []
  def initialize(name)
    @name = name
    @trains = []
    valid?(validate_station_name!)
    @@stations << self
    register_instance
  end


  class << self
    def all
      @@stations
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

  protected
  def validate_station_name!
    raise "Station name cannot be nil" if name.nil? || name.empty?
    raise "Station name should have 1 or more characters" if name.to_s.length < 1
    true
  end
end
