class Api::V1::AntipodeController < ApplicationController

  def show
    antipode = AntipodeFacade.get_antipode_info(params[:location])
    serialized_antipode = AntipodeSerializer.new(antipode)
    render json: serialized_antipode
  end

end