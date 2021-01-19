class Api::V1::ForecastController < ApplicationController

  def index
    location = params[:location]
    forecast = ForecastFacade.get_weather(location)
      if forecast.class == Forecast
        render json: ForecastSerializer.new(forecast)
      else
        render body: "ERROR: #{forecast[:info][:messages][0]}", status: 400
      end
  end
end
