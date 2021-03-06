
require './models/station'

require './models/train/cargo_train'
require './models/train/passenger_train'
require './models/route'
require './models/car/car'
require './models/car/cargo_car'
require './models/car/passenger_car'

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
      break if input.zero?
      execute_command(input)
    end
  end

  private # these methods are private because they are just used inside main methods internally
  def train_type_valid?(train_type)
    train_type.downcase == 'p' || train_type.downcase == 'c'
  end

  def show_interface
    puts '1 Create Station'
    puts '2 Create Train'
    puts '3 Create and manage route'
    puts '4 Set route to train'
    puts '5 Add carriage to train'
    puts '6 Remove carriage from train'
    puts '7 Move train throught route'
    puts '8 Show station list and train list on station'
    puts '9 Fill car'
    puts '0 Exit'
  end

  def manage_route_interface
    puts '1 Add Station to the Route'
    puts '2 Remove Station from the Route'
    puts '3 Show all stations in the route'
    puts '0 Exit from the route manager'
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
      when 9 then fill_car
    end
  end

  def user_input(word)
    puts word
    gets.chomp
  end

  def create_station
    station_name = user_input('Enter station name')
    station = Station.new(station_name)
    @stations << station unless @stations.any? { |obj| obj.name == station.name }
    puts 'station was created successfully'
    station
  end

  def create_train
    train_type = user_input('Enter train_type: c - cargo, p - passenger')
    puts 'enter p or c' unless train_type_valid?(train_type)
    return  unless train_type_valid?(train_type)
    attempt = 0
    begin
      train_number = user_input('Enter train number. Use correct format i.e: abc-34')
      train_klass_hash = {p: PassengerTrain, c:CargoTrain}
      train_klass = train_klass_hash[train_type.downcase.to_sym]
      train = create_train_object(train_klass, train_number)
    rescue RuntimeError => e
      attempt += 1
      create_train_err_message(attempt, e)
      retry if attempt < 5
    end
    train
  end

  def create_train_err_message(attempt, e)
    puts 'Cannot create train'
    puts "Something went wrong. There were #{attempt} attempts to create this train."
    puts "#{e.message}\n"
    puts 'You will haev up to 5 atttempts to create a train'
  end

  def create_train_object(train_klass,train_number)
    train = train_klass.new(train_number)
    @trains << train unless @trains.include?(train)
    puts "Train with number #{train.number} was successfully created"
    train
  end

  def create_route
    puts 'Creating start station ... '
    start_station = create_station

    puts 'Creating end station ... '
    end_station = create_station

    new_route = Route.new(start_station, end_station)
    new_route = manage_route(new_route)
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

      car_number = user_input('What is car number?')
      car_type = user_input('What is car type? - c or p')

      car_space = get_car_space(car_type)

      result = create_carriage(car_type, car_number, car_space, train)
      show_train_cars(train_index.to_i - 1)
    else
      puts 'Train index cannot be less then 1'
    end
  end

  def get_car_space(car_type)
    input_hash = {p: 'How many seats are in the car?', c: 'What is the maximum volume in the car?'}
    key = car_type.downcase.to_sym
    car_space = user_input(input_hash[key])
    car_space if car_space
  end

  def remove_carriage
    train_index = choose_train

    puts 'Train index cannot be less then 1' if train_index.to_i < 1
    return  if train_index.to_i < 1

    index = train_index - 1
    show_train_cars(index)
    car_index = user_input 'Enter car index to remove'
    car = @trains[index].carriagies[car_index.to_i - 1]
    @trains[index].dettach_car car
    show_train_cars(index)
  end

  def move_train
    train_index = choose_train
    index = train_index - 1
    train = @trains[index]
    current_route = @trains[index].route

    puts "Route of the train: #{print_routes current_route}"

    set_train_speed(train)
    manipulate_train_stations(current_route, train)
  end

  def show_stations_and_trains
    station_index = choose_station
    index = station_index.to_i - 1
    puts @stations[index].inspect
    @stations[index].each_train do |train, index|
      puts "#{index}: #{train.type} #{train.number}"
    end
  end

  def print_routes(route)
    stations_names = []
    stations_names = route.stations_list.map(&:name)
    puts stations_names
  end

  def route_for_train(train, route)
    puts 'There is no train or route. Please try again' unless train && route
    return unless train && route

    train.create_route(route)
    route.stations_list[0].add_train(train)
    puts 'You have successfully set route'
  end

  def show_all_routes
    return if @routes.nil? || @routes.count.zero?

    puts 'Existing routes: '
    @routes.each.with_index(1) do |route, index|
      print "#{index}: #{print_routes route} \n"
    end
  end

  def show_all_trains
    puts 'Existing trains: '
    @trains.each.with_index(1) do |train, index|
      puts "#{index}: #{train.type} #{train.number}"
    end
  end

  def choose_route_train
    reply = user_input('Do you want to set route for train? - y/n')
    return unless reply.casecmp("y").zero?

    chosen_train_type = user_input('Enter train type: ')
    chosen_train_number = user_input('Enter train number: ')
    chosen_route = user_input('Enter route number (i.e. 1): ')

    puts 'Route index cannot be less then 1' unless valid_route_index?(chosen_route)
    return unless valid_route_index?(chosen_route)

    train = @trains.find { |t| t.type == chosen_train_type && t.number == chosen_train_number }
    route_index = chosen_route.to_i - 1
    route_for_train(train, @routes[route_index])
  end

  def valid_route_index?(chosen_route)
    chosen_route.to_i > 0
  end

  def create_carriage(car_type, car_number, car_space, train)
    return if not_valid_car_type?(car_type)
    car_klass = {p: PassengerCar, c: CargoCar}
    car = car_klass[car_type.to_sym].new(car_number.to_i, car_space.to_i)
    attach_car_to_train(train, car)

    train
  end

  def valid_car_type?(car_type)
    car_type == 'p' || car_type == 'c'
  end

  def not_valid_car_type?(car_type)
     puts 'Wrong car type'
    !valid_car_type?(car_type)
  end

  def fill_car
    train_index = choose_train
    train_index = train_index.to_i - 1

    show_train_cars(train_index)
    car_index = user_input('Choose car index.')
    car_index = car_index.to_i - 1
    car = @trains[train_index].carriagies[car_index]
    fill_car_by_type(car)
  end

  def fill_car_by_type(car)
    if car.instance_of? CargoCar
      volume = user_input 'enter volume you want to fill in'
      car.take_up_volume(volume.to_f)
      puts "remaining volume is #{car.available_volume}"
    else
      car.take_seat
      puts "There are #{car.available_seats} available seats left in this car"
    end
  end

  def attach_car_to_train(train, car)
    train.attach_car(car)
  end

  def show_train_cars(index)
    @trains[index].each_car do |car, i|
      puts "#{i}: #{car}"
    end
  end

  def show_route_info(route, station_index)
    puts "Current station #{route.stations_list[station_index].name}"
    puts "Previous station #{route.stations_list[station_index - 1].name}" if station_index > 0
    puts "Next station #{route.stations_list[station_index + 1].name}" if station_index < route.stations_list.count - 1
  end

  def set_train_speed(train)
    train_speed = user_input 'Set train speed '
    train.speed_up(train_speed.to_i)
    puts "trains speed is #{train.speed}"
  end

  def stop_train(train)
    train.stop
  end

  def choose_train
    show_all_trains
    train_index = user_input 'Choose train index'
    train_index.to_i
  end

  def manipulate_train_stations(current_route, train)
    if current_route.nil?
      puts 'there is no route set for this train'
      return
    end
    loop do
      # add current,previous and next stations to  show
      show_route_info(current_route, train.station_index)
      choice = user_input('Where do you want to move train? (forward/back/stop)')
      case choice.downcase.to_sym
      when :forward then train.move_forward
      when :back then train.move_backwards
      when :stop
        stop_train(train)
        break
      else
        break
      end
    end
  end

  def add_station_to_route(route)
    if @stations.count == 2
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
    station_to_delete = user_input('Enter name of the station to delete:')
    outcome = route.delete_station(station_to_delete)
    puts outcome
    puts route.stations_list.inspect
  end

  def list_all_route_stations(route)
    puts '*' * 50
    route.stations_list.each.with_index(1) do |station, index|
      puts "#{index}: #{station.name}"
    end
    puts '*' * 50
  end

  def manage_route(route)
    reply = user_input 'Would you like to perform operations for this route? - y/n'
    return unless reply.casecmp('y').zero?
    loop do
      choice = manage_route_interface
      case choice
      when 1 then add_station_to_route(route)
      when 2 then remove_station_from_route(route)
      when 3 then list_all_route_stations(route)
      when 0 then break
      else
        puts 'Input was wrong. Try again.'
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
    station_index = user_input('Choose station index')
    station_index
  end
end

m = Main.new
m.start
