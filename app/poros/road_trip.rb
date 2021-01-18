class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(trip_data, origin=nil, destination=nil)
    @id = nil
    if trip_data.class == Array
      @start_city = trip_data[0]
      @end_city = trip_data[1]
      @travel_time = trip_data[2]
      @weather_at_eta = {
        temperature: trip_data[3],
        conditions: trip_data[4]
      }
    else
      @start_city = origin
      @end_city = destination
      @travel_time = "impossible"
      @weather_at_eta = nil
    end
  end
end

# def convert_time(seconds)
#   "%02d:%02d:%02d" % [seconds / 3600, seconds / 60 % 60, seconds % 60]
# end
