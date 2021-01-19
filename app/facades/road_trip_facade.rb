class RoadTripFacade
  def self.create_trip(params)
    trip_data = MapquestFacade.get_trip(params)
      if trip_data[:info][:statuscode] == 611
        return trip_data[:info][:messages][0]
      elsif trip_data[:info][:statuscode] == 0
        arrival_time = Time.now + (trip_data[:route][:realTime])
        weather_time = (arrival_time + 1800).beginning_of_hour

        weather_object = ForecastFacade.get_weather(params[:destination])
        hourly_array = weather_object.hourly_weather

        actual_weather = detect_eta_weather(weather_time, hourly_array)

        RoadTrip.new(trip_data, params, actual_weather)
      else
        RoadTrip.new(trip_data, params) 
      end
  end

  def self.detect_eta_weather(time, hours)
    hours.detect do |hour|
      (time.strftime("%H:%M:%S")) == hour.time
    end
  end
end
