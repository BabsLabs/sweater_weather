class Api::V1::BackgroundsController < ApplicationController

  def show
    background_url = UnsplashAPIService.new(params[:location])
    serialized_url = UnsplashApiServiceSerializer.new(background_url)
    render json: serialized_url
  end

end