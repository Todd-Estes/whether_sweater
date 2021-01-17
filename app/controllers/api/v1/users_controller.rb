class Api::V1::UsersController < ApplicationController

  def create
    new_user = User.new(user_params)
    if new_user.save
      render json: UsersSerializer.new(new_user), status: 201
    else
     render body: create_error_message(new_user), status: 400
    end

  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def create_error_message(resource)
    error_message = 'ERROR: '
      resource.errors.messages.each do |attribute, message|
        error_message += ("#{attribute} #{message[0]}; ")
      end
    return error_message.delete_suffix('; ')
  end
end
