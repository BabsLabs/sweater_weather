class Api::V1::AntipodeController < ApplicationController

  def show
    antipode_facade = AntipodeFacade
    antipode = antipode_facade.get_antipode_info(params[:location])

    render json: antipode
  end

end