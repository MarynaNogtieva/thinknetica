=begin
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций.
Начальная и конечная станции указываютсся при создании маршрута,
 а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_reader :stations_list

  def initialize(start_station,end_station)
    @stations_list = [start_station,end_station]
  end

  def add_station(station)
    stations_list.insert(-2,station)
  end

  def delete_station(station)
    stations_list.delete(station) if station != stations_list[0] && station != stations_list[-1]
  end

  def show_sorted_list
     stations_list.each.with_index(1) do |station_name,index|
       puts "#{index}: #{station_name}"
     end
  end
end
