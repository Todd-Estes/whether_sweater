require "rails_helper"

describe 'Roadtrip Poro', :vcr do
    it "exists" do
      params = {"origin": "Atlanta,GA",
                "destination": "Dallas, TX"}
      trip_data = MapquestService.trip_results(params)
      eta_time = RoadTripFacade.get_arrival_time(trip_data[:route][:realTime])
      weather_time = RoadTripFacade.round_eta_time(eta_time)
      two_day_array = RoadTripFacade.get_weather(params[:destination])
      actual_weather = RoadTripFacade.detect_eta_weather(weather_time, two_day_array)
      road_trip_object = RoadTrip.new(trip_data, params, actual_weather)

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

    it "can enter an impossible location and receive a different data structure" do
      params = {"origin": "Atlanta,GA",
                "destination": ""}
      trip_data = MapquestService.trip_results(params)
      road_trip_object = RoadTrip.new(trip_data, params)

      expect(road_trip_object).to be_a(RoadTrip)
      expect(road_trip_object.id).to eq(nil)
      expect(road_trip_object.start_city).to be_a(String)
      expect(road_trip_object.end_city).to be_a(String)
      expect(road_trip_object.travel_time).to be_a(String)
      expect(road_trip_object.weather_at_eta).to eq(nil)
    end
 end
