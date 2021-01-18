class Hourly
  attr_reader :time, :temperature, :wind_speed, :wind_direction, :conditions, :icon

  def initialize(data)
    @time = Time.at(data[:dt]).strftime("%H:%M:%S")
    @temperature = data[:temp]
    @wind_speed = "#{data[:wind_speed]} mph"
    @wind_direction = find_direction(data[:wind_deg].to_f)
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def find_direction(degree)
    case degree
    when 11.25..33.75
      'from NNE'
    when 33.76..56.25
      'from NE'
    when 56.26..78.75
      'from ENE'
    when 78.76..101.25
      'from E'
    when 101.26..123.75
      'from ESE'
    when 123.76..146.25
      'from SE'
    when 146.26..168.75
      'from SSE'
    when 168.76..191.25
      'from S'
    when 191.26..213.75
      'from SSW'
    when 213.76..236.25
      'from SW'
    when 236.26..258.75
      'from WSW'
    when 258.76..281.25
      'from W'
    when 281.26..303.75
      'from WNW'
    when 303.76..326.25
      'from NW'
    else
      "from N"
    end
  end
end
