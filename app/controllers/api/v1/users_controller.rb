class Api::V1::UsersController < ApplicationController

  def create
    user = User.create(user_params)
    if user.save
      serialized_user = UserSerializer.new(user)
      render json: serialized_user
    else
      render json: {status: "error", code: 400, message: user.errors.full_messages.to_sentence}
    end
  end

  private
    def user_params
      params.permit(:email, :password)
    end
end