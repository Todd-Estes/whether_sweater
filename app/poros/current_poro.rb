class CurrentPoro
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @datetime = data[:dt]
    @sunrise = data[:sunrise]
    @sunset = data[:sunset]
    @temperature = data[:temp]
    @feels_like = data[:feels_like]
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]
    @conditons = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end
