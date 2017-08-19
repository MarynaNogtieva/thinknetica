
require './station'

require './cargo_train'
require './passenger_train'
require './route'
require './car'
require './cargo_car'
require './passenger_car'

class Main
  attr_reader :routes, :trains, :stations

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def start
    loop do
      show_interface
      input = gets.to_i
      break if input == 0
      execute_command(input)
    end
  end

  private #these methods are private because they are just used inside main methods internally
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
     puts "0 Exit from the route manager"
     gets.chomp.to_i
   end

  def execute_command(input)
    case input
    when 1 then create_station
    when 2 then create_train
    when 3 then create_route
    when 4 then show_routes_and_trains
    when 5 then add_carriage
    when 6 then remove_carriage
    when 7 then move_train
    when 8 then show_stations_and_trains
    end
  end

  def user_input(word)
    puts word
    gets.chomp
  end

  def create_station
    station_name = user_input "Enter station name"
    station = Station.new(station_name)
    @stations << station unless @stations.any? {|obj| obj.name == station.name}
    puts "station was created successfully"
    station
  end

  def create_train
    train_type = user_input("Enter train_type: c - cargo, p - passenger")
    train_number = user_input("Enter train number")
    train_klass =
    case train_type.downcase
    when 'p' then PassengerTrain
    when 'c' then CargoTrain
    end
     if train_klass
      train = train_klass.new(train_number.to_i)
      @trains << train unless @trains.include?(train)
     else
      puts "enter p or c"
     end
     train
  end

  def create_route
    puts "Creating start station ... "
    start_station = create_station

    puts "Creating end station ... "
    end_station = create_station

    new_route = Route.new(start_station,end_station)
    new_route = manage_route new_route
    @routes << new_route
    new_route
  end

  def show_routes_and_trains
    show_all_routes
    show_all_trains
    choose_route_train
  end

  def add_carriage
    train_index = choose_train

    if train_index.to_i > 0
    train = @trains[train_index - 1]

    car_number = user_input("What is car number?")
    car_type = user_input("What is car type? - c or p")

    result = create_carriage(car_type,car_number,train)
    show_train_cars(train_index.to_i-1)
    else
    puts "Train index cannot be less then 1"
    end
  end

  def remove_carriage
    train_index = choose_train

    if train_index.to_i > 0
      index = train_index - 1
      show_train_cars(index)
      car_index = user_input "Enter car index to remove"
      car = @trains[index].carriagies[car_index.to_i - 1]
      @trains[index].dettach_car car
      show_train_cars(index)
    else
      puts "Train index cannot be less then 1"
    end
  end

  def move_train
    train_index = choose_train
    index = train_index - 1
    train = @trains[index]
    current_route = @trains[index].route

    puts "Route of the train: #{print_routes current_route}"

    set_train_speed(train)
    manipulate_train_stations(current_route,train)
  end

  def show_stations_and_trains
    station_index = choose_station
    index = station_index.to_i - 1
    puts @stations[index].inspect
    @stations[index].trains.each.with_index(1) do |train, index|
       puts "#{index}: #{train.type} #{train.number}"
    end
  end



  def print_routes(route)
    stations_names = []
    stations_names = route.stations_list.map do |station|
      station.name
    end
    puts stations_names
  end

  def set_route_for_train(train,route)
    if(train && route)
      train.set_route route
      puts "You have successfully set route"
    else
      puts "There is no train or route. Please try again"
    end
  end

  def show_all_routes
    puts "Existing routes: "
    @routes.each.with_index(1) do |route,index|
      puts "#{index}: #{print_routes route} "
    end
  end

  def show_all_trains
    puts "Existing trains: "
    @trains.each.with_index(1) do |train,index|
      puts "#{index}: #{train.type} #{train.number}"
    end
  end


  def choose_route_train
      reply = user_input("Do you want to set route for train? - y/n")
      if reply.downcase == "y"
        chosen_train_type = user_input("Enter train type: ")
        chosen_train_number = user_input("Enter train number: ")
        chosen_route = user_input("Enter route number (i.e. 1): ")
        if (chosen_route.to_i > 0)
          train = @trains.find {|t| t.type == chosen_train_type && t.number == chosen_train_number.to_i}
          route_index = chosen_route.to_i - 1
          set_route_for_train(train,@routes[route_index])

        else
          puts "Route index cannot be less then 1"
        end
    end
  end

  def create_carriage(car_type,car_number,train)
    car_klass =
    case car_type.downcase
    when "p" then PassengerCar
    when "c" then CargoCar
    end
    if car_klass
      car = car_klass.new(car_number.to_i)
      attach_car_to_train(train,car)
    else
      puts "Wrong car type"
    end
    train
  end

  def attach_car_to_train(train,car)
      train.attach_car(car) unless train.type != car.type
  end

  def show_train_cars(index)
    @trains[index].carriagies.each.with_index(1) do |car,i|
      puts "#{i}: #{car.number}"
    end
  end

  def show_route_info(route,station_index)
    puts "Current station #{route.stations_list[station_index].name}"
    puts "Previous station #{route.stations_list[station_index-1].name}" if station_index > 0
    puts "Next station #{route.stations_list[station_index+1].name}" if station_index < route.stations_list.count - 1
  end

  def set_train_speed(train)
    train_speed = user_input "Set train speed "
    train.speed_up(train_speed.to_i)
    puts "trains speed is #{train.speed}"
  end

 def stop_train(train)
   train.stop
 end

  def choose_train
    show_all_trains
    train_index = user_input "Choose train index"
    train_index.to_i
  end

  def manipulate_train_stations(current_route,train)
    if current_route.nil?
      puts "there is no route set for this train"
      return
    end
    loop do
      #add current,previous and next stations to  show
      show_route_info(current_route, train.station_index)
      choice = user_input("Where do you want to move train? (forward/back/stop)")
      case choice.downcase
      when "forward" then train.move_forward
      when "back" then train.move_backwards
      when "stop"
        stop_train(train)
        break
      else
        break
      end
    end
  end

  def add_station_to_route(route)
    if  @stations.count == 2
      new_route_station = create_station
      route.add_station(new_route_station)
    else
      station_index = choose_station
      index = station_index.to_i - 1
      new_route_station = @stations[index]
      route.add_station(new_route_station)
    end
  end

  def remove_station_from_route(route)
    station_to_delete = user_input("Enter name of the station to delete:")
    outcome = route.delete_station(station_to_delete)
    puts outcome
    puts route.stations_list.inspect
  end

  def list_all_route_stations(route)
    puts "*" * 50
    route.stations_list.each.with_index(1) do |station,index|
      puts "#{index}: #{station.name}"
    end
    puts "*" * 50
  end

  def manage_route(route)
  reply = user_input "Would you like to perform operations for this route? - y/n"
    return unless reply.downcase == 'y'
      loop do
       choice = manage_route_interface
       case choice
       when 1 then add_station_to_route(route)
       when 2 then remove_station_from_route(route)
       when 3 then list_all_route_stations(route)
       when 0 then  break
       else
         puts "Input was wrong. Try again."
       end
     end
    route
  end

   def show_all_stations
     puts "All existing stations: \n"
     @stations.each.with_index(1) do |station, index|
       puts "#{index}: #{station.name}"
     end
   end

  def choose_station
    show_all_stations
    station_index = user_input("Choose station index")
    station_index
  end
end

m = Main.new
m.start
