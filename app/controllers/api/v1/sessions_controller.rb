class Api::V1::SessionsController < ApplicationController

  def create
    current_user = User.find_by(email: session_params[:email])
    if current_user && current_user.authenticate(session_params[:password])
      render json: UsersSerializer.new(current_user), status: 200
    elsif session_params[:email] == nil || session_params[:password] == nil
      render body: "ERROR: Cannot leave user email or password blank", status: 400
    else
      render body: "ERROR: Invalid email or password; unable to authenticate",  status: 401
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
