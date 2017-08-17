
require './station'

require './cargo_train'
require './passenger_train'
require './route'
require './car'
require './cargo_car'
require './passenger_car'
require './train'
class Main
  attr_reader :routes, :trains, :stations

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def show_interface
    puts "1 Create Station"
    puts "2 Create Train"
    puts "3 Create and manage route"
    puts "4 Set route to train"
    puts "5 Add carriage to train"
    puts "6 Remove carriage from train"
    puts "7 Move train throught route"
    puts "8 Show station list and train list on station"
    puts "0 Exit"
  end

   def manage_route_interface
     puts "1 Add Station to the Route"
     puts "2 Remove Station from the Route"
     puts "3 Show all stations in the route"
     puts "0 xit from the route manager"
     gets.chomp.to_i
   end

  def execute_command(input)
    case input
    when 1 then create_station
    when 2 then create_train
    when 3 then create_route
    when 4
    when 5
    when 6
    when 7
    when 8
    end
  end

  def user_input word
    puts word
    gets.chomp
  end

  def create_station
    station_name = user_input "Enter station name"
    station = Station.new(station_name)
    @stations << station unless @stations.any? {|obj| obj.name == station.name}
    puts @stations.inspect
    station
  end

  def create_train
    train_type = user_input "Enter train_type: c - cargo, p - passenger"
    train_number = user_input "Enter train number"
     if train_type.downcase == "p"
       train = PassengerTrain.new(train_number.to_i)
       @trains << train unless @trains.any? {|obj| obj.number == train.number}
     elsif train_type.downcase == "c"
       CargoTrain.new(train_number.to_i)
       @trains << train
     end
     train
  end

  def create_route
    puts "Creating start station ... "
    start_station = create_station

    puts "Creating end station ... "
    end_station = create_station

    new_route = Route.new(start_station,end_station)
    puts new_route.inspect
    new_route = manage_route new_route

    @routes << new_route
    new_route
  end

  def add_station_to_route route
    new_route_station = create_station
    route.add_station(new_route_station)
  end

  def remove_station_from_route route
    station_to_delete = user_input "Enter name of the station to delete:"
    outcome = route.delete_station(station_to_delete)
    puts outcome
    puts route.stations_list.inspect
  end

  def list_all_route_stations route
    puts "*" * 50
    route.stations_list.each.with_index(1) do |station,index|
      puts "#{index}: #{station.name}"
    end
    puts "*" * 50
  end

  def manage_route route
  reply = user_input "Would you like to perform operations for this route? - y/n"
    if reply.downcase == "y"
      loop do
         choice = manage_route_interface
         if choice == 1
           add_station_to_route route
         elsif choice == 2
           remove_station_from_route route
         elsif choice == 3
           list_all_route_stations route
         elsif choice == 0
           break
         else
           puts "Input was wrong. Try again."
         end
      end
    end
    route
  end



  def main_method
    loop do
      show_interface
      input = gets.chomp.to_i
      break if input == 0
      execute_command(input)
    end
  end

end

m = Main.new
m.main_method
