class ForecastFacade
  def self.get_weather(location)
    result = MapquestService.city_results(location)
    params = result[:results][0][:locations][0][:latLng]
    results = WeatherService.get_forecast(params)

    current = CurrentPoro.new(results[:current])

    daily = create_daily_poro(results[:daily][0..4])

    hourly = create_hourly_poro(results[:hourly][0..7])

    Forecast.new(current, daily, hourly)
  end

  def self.create_daily_poro(data)
    data.map do |daily_data|
      Daily.new(daily_data)
    end
  end

  def self.create_hourly_poro(data)
    data.map do |hourly_data|
      Hourly.new(hourly_data)
    end
  end
end
