
require './station'

require './cargo_train'
require './passenger_train'
require './route'
require './car'
require './cargo_car'
require './passenger_car'
require './train'



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



  def execute_command(input)
    case input
    when 1
      @new_station = create_station
      puts "new station was created"
    when 2
      @new_train = create_train
    when 3
      @new_route = create_route
    when 4
    when 5
    when 6
    when 7
    when 8
    end
  end

  def user_input word
    puts "Enter #{word}: "
    gets.chomp
  end

  def create_station
    station_name = user_input "station name"
    Station.new(station_name)
  end

  def create_train
    train_type = user_input "train_type: c - cargo, p - passenger"
    train_number = user_input "train number"
    PassengerTrain.new(train_number.to_i) if train_type.downcase == "p"
    CargoTrain.new(train_number.to_i) if train_type.downcase == "c"
  end

  def create_route
    puts "Creating start station ... "
    start_station = create_station
    puts "Creating end station ... "
    end_station = create_station
    Route.new(start_station,end_station)
  end


  loop do
    show_interface
    input = gets.chomp.to_i
    break if input == 0
    execute_command(input)
  end
