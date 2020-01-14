class Api::V1::UsersController < ApplicationController

  def create
    user = User.create(user_params)
    serialized_user = UserSerializer.new(user)
    render json: serialized_user
  end

  private
    def user_params
      params.permit(:email, :password)
    end
end