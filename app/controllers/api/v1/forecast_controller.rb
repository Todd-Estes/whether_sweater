class Api::V1::ForecastController < ApplicationController

  def show
    location = params[:location]
    forecast = ForecastFacade.get_weather(location)
    render json: ForecastSerializer.new(forecast)

  end

end
