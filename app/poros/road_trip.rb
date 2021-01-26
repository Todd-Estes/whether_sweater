class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(trip_data, params, actual_weather=nil)
      @id = nil
    unless actual_weather.nil?
      @start_city = params[:origin]
      @end_city = params[:destination]
      @travel_time = Time.at(trip_data[:route][:realTime]).utc.strftime("%H:%M:%S")
      # @travel_time = actual_weather.time
      @weather_at_eta = {
        temperature: actual_weather.temperature,
        conditions: actual_weather.conditions
      }
    else
      @start_city = params[:origin]
      @end_city = params[:destination]
      @travel_time = "impossible"
      @weather_at_eta = nil
    end
  end
end
