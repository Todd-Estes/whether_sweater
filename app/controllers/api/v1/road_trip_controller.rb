class Api::V1::RoadTripController < ApplicationController

  def index
    reg_user = User.find_by(api_key: road_trip_params[:api_key])
      if reg_user
        trip_data = RoadTripFacade.create_trip(road_trip_params)
        if trip_data.class == RoadTrip
          render json: RoadtripSerializer.new(trip_data)
        elsif trip_data.class == String
          render body: "ERROR: #{trip_data}", status: 400
        end
      else
        render body: "Unauthorized: invalid or missing token", status: 401
      end
  end

  private

    def road_trip_params
      params.permit(:origin, :destination, :api_key)
    end
end
