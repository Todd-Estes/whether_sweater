class RoadTripFacade
  def self.create_trip(origin, destination)
    trip_data = MapquestFacade.get_trip(origin, destination)
    if trip_data.class == Array
      RoadTrip.new(trip_data)
    elsif trip_data[:info][:statuscode] == 402
      RoadTrip.new(trip_data, origin, destination)
    else
      trip_data[:info][:messages][0]
    end
  end
end
