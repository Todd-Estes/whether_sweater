class Api::V1::MunchiesController < ApplicationController

  def index
    MunchiesFacade.get_munchies(params)
  end


  private
   def munchies_params
     params.permit(:start, :end, :food)
   end
end
