class Station
  attr_reader :all_trains

  def initialize(st_name)
    @st_name = st_name
    @all_trains = []
    @trains_type = []
  end

  def add_train(train)
    @all_trains << train
  end

  def show_type(type)
    @all_trains.select {|tr| tr.type == type}.size
  end

  def remove_train(train)
    return unless @all_trains.include?(train)

    @all_trains.delete(train)
  end
end

class Route
  attr_reader :start_station, :end_station, :route_stations, :mid_stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @route_stations = []
    @mid_stations = []
  end
  
  def add_middle_st(station)
    @mid_stations << station
  end

  def remove_station(station)
    return unless @mid_stations.include?(station)

    @mid_stations.delete(station)
  end

  def route_stations
    [@start_station, @mid_stations, @end_station].flatten.compact
  end
end

class Train
attr_accessor :current_speed
attr_reader :number, :type, :num_wagons

  def initialize(type, number, num_wagons, current_speed = 0, route)
    @route = route
    @type = type
    @number = number
    @num_wagons = num_wagons
    @current_speed = current_speed
    @stations_straight = route&.route_stations ||= []
    @stations_passed = []
    @current_station = @stations_straight.shift
  end
  
  def up_speed
    @current_speed += 10
  end

  def slow_down
    @current_speed = 0
  end
  
  def add_num_wagons
    return "you need slow down" unless @current_speed == 0
    
    @num_wagons += 1
  end

  def get_num_wagons
    return "you need slow down" unless @current_speed == 0

    @num_wagons -= 1
  end

  def move(action)
    case action
    when "up"
      up_action
    when "back"
      down_action
    else
      puts "err"
    end
  end

  def next_station
    return if @stations_straight.empty?

    @stations_straight.first
  end

  def previous_station
    return if @stations_passed.empty?

    @stations_passed.last
  end

  private

  def up_action
    return "Move to straight is not allowed" unless next_station

    @stations_passed << @current_station
    @current_station = @stations_straight.shift
  end

  def down_action
    return "Move to back is not allowed" unless previous_station
    
    @stations_straight.unshift(@current_station)
    @current_station = @stations_passed.pop
  end
end


