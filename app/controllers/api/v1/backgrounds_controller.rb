class Api::V1::BackgroundsController < ApplicationController

  def show
    background = BackgroundFacade.find_background(params[:location])
    serialized_background = BackgroundSerializer.new(background)
    render json: serialized_background
  end

end