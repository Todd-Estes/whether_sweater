class MunchiesFacade
  def self.get_munchies(params)
    weather_object = ForecastFacade.get_weather(params)
    hourly_array = weather_object.hourly_weather

    route_body = MapquestFacade.get_trip(params)

    eta_time = get_arrival_time(route_body[:route][:realTime])
    weather_time = round_eta_time(eta_time)

    eta_weather = detect_eta_weather(weather_time, hourly_array)
    require "pry"; binding.pry

    open_time = convert_time(weather_time)


    restaurant_info = YelpFacade.get_restaurant(params, open_time)
  end



    def self.get_arrival_time(travel_time)
      Time.now + (travel_time)
    end

    def self.round_eta_time(eta)
      (eta + 1800).beginning_of_hour
    end

    def self.convert_time(timestamp)
      timestamp.strftime('%s').to_i
    end

    def self.detect_eta_weather(time, hours)
      hours.detect do |hour|
        (time.strftime("%H:%M:%S")) == hour.time
      end
    end
  end
