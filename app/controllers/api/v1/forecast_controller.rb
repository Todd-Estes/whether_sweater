class Api::V1::ForecastController < ApplicationController

  def show
    city = params[:location]
    forecast = ForecastFacade.get_weather(city)
    hash = render json: ForecastSerializer.new(forecast)
  end

end
