class Api::V1::ForecastController < ApplicationController

  def index
  location = GoogleAPIService.new(params[:location])
  end

end