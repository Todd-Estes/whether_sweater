require "rails_helper"

describe 'Road Trip Facade', :vcr do
  describe 'class methods' do
    it "can call create trip and create a RoadTrip poro" do
      params = {"origin": "Atlanta,GA",
                "destination": "Dallas, TX"}
      trip_data = MapquestService.trip_results(params)
      road_trip_object = RoadTripFacade.create_trip(trip_data, params)

      expect(road_trip_object).to be_a(RoadTrip)
      expect(road_trip_object).to be_a(RoadTrip)
      expect(road_trip_object.id).to eq(nil)
      expect(road_trip_object.start_city).to be_a(String)
      expect(road_trip_object.end_city).to be_a(String)
      expect(road_trip_object.travel_time).to be_a(String)

      expect(road_trip_object.weather_at_eta).to be_a(Hash)
      expect(road_trip_object.weather_at_eta).to have_key(:temperature)
      expect(road_trip_object.weather_at_eta[:temperature]).to be_a(Numeric)
      expect(road_trip_object.weather_at_eta).to have_key(:conditions)
      expect(road_trip_object.weather_at_eta[:conditions]).to be_a(String)
    end

    it "can create a RoadTrip poro with no weather params and create different data structure" do
      params = {"origin": "Atlanta,GA",
                "destination": "London"}
      trip_data = MapquestService.trip_results(params)

      road_trip_object = RoadTripFacade.bad_location(trip_data, params)
      expect(road_trip_object).to be_a(RoadTrip)
      expect(road_trip_object.id).to eq(nil)
      expect(road_trip_object.start_city).to be_a(String)
      expect(road_trip_object.end_city).to be_a(String)
      expect(road_trip_object.travel_time).to be_a(String)
      expect(road_trip_object.weather_at_eta).to eq(nil)
    end
  end
end
