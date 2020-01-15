class Api::V1::ForecastController < ApplicationController

  def index
    forecast = WeatherFacade.get_weather_information(params[:location])
    serialized_forecast = ForecastSerializer.new(forecast)
    render json: serialized_forecast
  end

end
