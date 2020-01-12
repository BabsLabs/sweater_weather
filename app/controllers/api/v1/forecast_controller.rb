class Api::V1::ForecastController < ApplicationController

  def index
    latitude_and_longitude = GoogleAPIService.new(params[:location])

    forecast_results = DarkSkyAPIService.new(latitude_and_longitude)

    forecast_facade = ForecastFacade.new(forecast_results)

  end

end