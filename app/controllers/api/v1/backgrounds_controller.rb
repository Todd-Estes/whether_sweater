class Api::V1::BackgroundsController < ApplicationController

  def index
    if background_params[:location].empty?
      render body: "ERROR: Location entry cannot be blank", status: 400
    else
      location = background_params[:location]
      pic_data = BackgroundsFacade.get_background(location)
      render json: ImageSerializer.new(pic_data)
    end
  end

  private

    def background_params
      params.permit(:location)
    end
end
