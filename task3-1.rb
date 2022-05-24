class Station
  attr_reader :all_trains

  def initialize(st_name)
    @st_name = st_name
    @all_trains = []
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
  attr_reader :start_station, :end_station, :mid_stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
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
  attr_reader :number, :type, :num_wagons, :current_speed

  def initialize(type, number, num_wagons, current_speed = 0, route)
    @route = route
    @type = type
    @number = number
    @num_wagons = num_wagons
    @current_speed = current_speed
    @stations_straight = route.route_stations
    @current_station = 0
  end
  
  def up_speed
    @current_speed += 10
  end

  def slow_down
    @current_speed = 0
  end
  
  def add_num_wagons
    return unless @current_speed == 0
    
    @num_wagons += 1
  end

  def get_num_wagons
    return unless @current_speed == 0

    @num_wagons -= 1
  end

  def move_up
    up_action
  end

  def move_back
    down_action
  end

  def next_station
    return if @stations_straight.empty?
    return if @current_station + 1 >= @stations_straight.size

    @stations_straight[@current_station + 1]
  end

  def previous_station
    return if @stations_straight.empty?
    return unless @current_station.positive?

    @stations_straight[@current_station - 1]
  end

  private

  def up_action
    return unless next_station

    @current_station += 1
    {current_station:  @current_station}
  end

  def down_action
    return unless previous_station

    @current_station -= 1
    {current_station:  @current_station}
  end
end
