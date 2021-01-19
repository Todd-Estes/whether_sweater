class Api::V1::MunchiesController < ApplicationController

  def index
    
  end


  private
   def munchies_params
     params.permit(:start, :end, :food)
end
