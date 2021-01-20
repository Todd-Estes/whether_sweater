class Api::V1::ForecastController < ApplicationController

  def index
    location = forecast_params[:location]
    forecast = ForecastFacade.get_weather(location)
      if forecast.class == Forecast
        render json: ForecastSerializer.new(forecast)
      else
        render body: "ERROR: #{forecast[:info][:messages][0]}", status: 400
      end
  end


  private

    def forecast_params
      params.permit(:location)
    end
end
