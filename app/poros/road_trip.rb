class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(trip_data, params, weather_array=nil)
      @id = nil
    if trip_data[:info][:statuscode] == 0
      @start_city = params[:origin]
      @end_city = params[:destination]
      @travel_time = weather_array.time
      @weather_at_eta = {
        temperature: weather_array.temperature,
        conditions: weather_array.conditions
      }
    else
      @start_city = params[:origin]
      @end_city = params[:destination]
      @travel_time = "impossible"
      @weather_at_eta = nil
    end
  end
end
