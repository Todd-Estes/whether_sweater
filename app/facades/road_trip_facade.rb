class RoadTripFacade
  def self.create_trip(trip_data, params)
    eta_time = get_arrival_time(trip_data[:route][:realTime])
    weather_time = round_eta_time(eta_time)
    two_day_array = get_weather(params[:destination])
    actual_weather = detect_eta_weather(weather_time, two_day_array)
    RoadTrip.new(trip_data, params, actual_weather)
  end

  def self.bad_location(trip_data, params)
    RoadTrip.new(trip_data, params)
  end

  def self.get_arrival_time(travel_time)
    Time.now + (travel_time)
  end

  def self.round_eta_time(eta)
    (eta + 1800).beginning_of_hour
  end

  def self.get_weather(location)
    result = MapquestService.city_results(location)
    params = result[:results][0][:locations][0][:latLng]
    forecast = WeatherService.get_forecast(params)
    hour_object = forecast[:hourly]
      forecast[:hourly].map do |hourly_data|
        Hourly.new(hourly_data)
      end
  end

  def self.detect_eta_weather(time, hours)
    hours.detect do |hour|
      (time.strftime("%H:%M:%S")) == hour.time
    end
  end
end
