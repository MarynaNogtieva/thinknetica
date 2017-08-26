require './car'
=begin
Для грузовых вагонов:
Добавить атрибут общего объема (задается при создании вагона)
Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
Добавить метод, который возвращает занятый объем
Добавить метод, который возвращает оставшийся (доступный) объем

=end
class CargoCar < Car
  attr_reader :type, :volume, :taken_volume

  def initialize(number, volume)
    super(number)
    @type = "Cargo"
    @volume = volume
    @taken_volume = 0
  end

  def take_up_volume(v)
    @taken_volume += v if @taken_volume < @volume
  end

  def available_volume
    @volume - @taken_volume
  end
end
