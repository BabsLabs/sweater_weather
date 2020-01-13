class Api::V1::AntipodeController < ApplicationController

  def show
    location = GoogleAPIService.new(params[:location])

    antipode = AntipodeService.new(location.latitude_and_longitude)

    

  end

end