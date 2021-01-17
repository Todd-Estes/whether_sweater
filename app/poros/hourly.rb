class Hourly
  attr_reader :time, :temperature, :wind_speed, :wind_direction, :conditions, :icon

  def initialize(data)
    @time = data[:dt]
    @temperature = data[:temp]
    @wind_speed = data[:wind_speed]
    @wind_direction = data[:wind_deg]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end
