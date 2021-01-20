class Api::V1::RoadTripController < ApplicationController

  def index
    reg_user = User.find_by(api_key: road_trip_params[:api_key])
      if reg_user
       trip_data = MapquestFacade.get_trip(road_trip_params)
         if trip_data[:info][:statuscode] == 402
            no_route = RoadTripFacade.bad_location(trip_data, road_trip_params)
            render json: RoadtripSerializer.new(no_route)
         elsif trip_data[:info][:statuscode] == 0
            road_trip_object = RoadTripFacade.create_trip(trip_data, road_trip_params)
            render json: RoadtripSerializer.new(road_trip_object)
         else
          render body: "ERROR: #{trip_data[:info][:messages][0]}", status: 400
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
