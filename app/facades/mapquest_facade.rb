class MapquestFacade
  def self.get_trip(origin, destination)
    trip_data = MapquestService.trip_results(origin, destination)
    require "pry"; binding.pry
      if trip_data[:info][:statuscode] == 0
    # if trip_data[:info][:statuscode] == 0
        destination_coords = MapquestService.city_results(destination)[:results][0][:locations][0][:latLng]
        location_weather = WeatherService.get_forecast(destination_coords)
        formatted_time = get_destination_time(trip_data)
        trip_time = trip_data[:route][:formattedTime]
        arrival_weather = destination_arrival_weather(location_weather, formatted_time)
        temperature = arrival_weather[0][:temp]
        conditions = arrival_weather[0][:weather][0][:description]
        return [origin, destination, trip_time, temperature, conditions]
      else
        return trip_data
      end
    end





  def self.get_destination_time(trip_data)
    time = Time.now + (trip_data[:route][:realTime])
      if time.min > 30
        time = time.beginning_of_hour
      else
        time = (time + 3600).beginning_of_hour
      end
    time
  end

  def self.destination_arrival_weather(location_weather, formatted_time)
    location_weather[:hourly].select do |hourly|
      formatted_time == Time.at(hourly[:dt])
    end
  end
end


  # "%02d:%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
