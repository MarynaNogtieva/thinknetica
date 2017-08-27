require './car'
=begin
Для грузовых вагонов:
Добавить атрибут общего объема (задается при создании вагона)
Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
Добавить метод, который возвращает занятый объем
Добавить метод, который возвращает оставшийся (доступный) объем

=end
class CargoCar < Car

  attr_reader  :volume, :taken_space

  def initialize(number, volume)
    super(number)
    @volume = volume
    @taken_space= 0
  end

  def take_up_volume(filled_volume)
    @taken_space += filled_volume unless @taken_space + filled_volume > @volume
  end

  def available_volume
    @volume - @taken_space
  end

  def to_s
    "Type: Cargo, number: #{number} , volume: #{volume}"
  end
end
