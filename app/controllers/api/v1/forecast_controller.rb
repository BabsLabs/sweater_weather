class Api::V1::ForecastController < ApplicationController

  def index
    location = GoogleAPIService.new(params[:location])

    forecast_results = DarkSkyAPIService.new(location.latitude_and_longitude)

    forecast_facade = ForecastFacade.new(forecast_results.forecast_info)

  end

end