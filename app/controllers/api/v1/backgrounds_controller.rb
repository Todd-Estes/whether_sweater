class Api::V1::BackgroundsController < ApplicationController

  def show
    location = params[:location]
    pic_data = BackgroundsFacade.get_background(location)
    render json: ImageSerializer.new(pic_data)
  end
end
