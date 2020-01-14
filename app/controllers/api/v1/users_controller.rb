class Api::V1::UsersController < ApplicationController

  def create
    user = User.create(user_params)
    if user.save
      serialized_user = UserSerializer.new(user)
      render json: serialized_user
    else
      render json: {message: user.errors.full_messages.to_sentence}, status: 400
    end
  end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end