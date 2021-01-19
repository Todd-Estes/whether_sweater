class Api::V1::MunchiesController < ApplicationController

  def index
    munchie_object = MunchiesFacade.get_munchies(params)
    var = render json: MunchieSerializer.new(munchie_object)
  end


  private
   def munchies_params
     params.permit(:start, :end, :food)
   end
end
