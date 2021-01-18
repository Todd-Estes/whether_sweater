class Api::V1::SessionsController < ApplicationController

  def create
    current_user = User.find_by(email: session_params[:email])
    if current_user && current_user.authenticate(session_params[:password])
      render json: UsersSerializer.new(current_user), status: 200
    else
      render body: "YOU CANT FOOL ME",  status: 400
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end

end
