# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута,
#  а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной
require './module/instance_counter'
require './module/validate'

class Route
  include InstanceCounter
  include Validate

  attr_reader :stations_list

  def initialize(start_station, end_station)
    validate!(start_station, end_station)
    @stations_list = [start_station, end_station]
    register_instance
  end

  def add_station(station)
    stations_list.insert(-2, station) unless @stations_list.any? { |obj| obj.name == station.name }
  end

  def delete_station(name)
    return 'There are no stations in this route' if stations_list.empty?

    if name == stations_list[0].name || name == stations_list[-1].name
      return 'you cannot remove start and end station'
    else
      stations_list.delete_if { |obj| obj.name == name }
      return 'Station was successfully removed from the route!'
    end
  end

  def validate!(start_station, end_station)
    raise 'one of the objects is not of a Station class' if start_station.class != Station || end_station.class != Station
  end
end
