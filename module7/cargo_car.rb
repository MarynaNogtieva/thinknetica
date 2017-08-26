require './car'
=begin
Для грузовых вагонов:
Добавить атрибут общего объема (задается при создании вагона)
Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
Добавить метод, который возвращает занятый объем
Добавить метод, который возвращает оставшийся (доступный) объем

=end
class CargoCar < Car

  attr_reader :type, :volume, :taken_space

  def initialize(number, volume)
    super(number)
    @type = "Cargo"
    @volume = volume
    @taken_space= 0
  end

  def take_up_volume(v)
    @taken_space+= v if @taken_space < @volume
  end

  def available_volume
    @volume - @taken_space
  end
end
