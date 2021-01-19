class Api::V1::UsersController < ApplicationController

  def create
    new_user = User.new(user_params)
    if new_user.save
      render json: UsersSerializer.new(new_user), status: 201
    else
      error_message = render_error_message(new_user.errors.messages)
      render body: "ERROR:#{error_message}", status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

    def render_error_message(messages)
      message_string = ''
      messages.map do |key, value|
        message_string += "#{key} #{value[0]}; "
      end
      message_string
    end
end
