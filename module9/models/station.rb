# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции)
# написать метод, который принимает блок и проходит по всем поездам на станции, передавая каждый поезд в блок.
require './module/instance_counter'
require './module/validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name
  validate :name, :presence
  validate :name, :type, type: String

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
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
    trains.select { |train| train.type == type }
  end

  def delete_train(train)
    trains.delete(train)
  end

  def each_train(block)
    return unless block_given?
    @trains.each.with_index(1) do |train, index|
      yield train, index
    end
  end
end
