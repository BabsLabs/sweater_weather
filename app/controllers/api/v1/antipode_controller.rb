class Api::V1::AntipodeController < ApplicationController

  def show
    antipode_facade = AntipodeFacade.new(params[:location])

    response = antipode_facade.get_info

    response.to_json
  end

end