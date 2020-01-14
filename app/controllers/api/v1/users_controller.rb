class Api::V1::UsersController < ApplicationController

  def create
    user = User.create(request.headers[:email], request.headers[:password], request.headers[:password_confirmation])
  end

end