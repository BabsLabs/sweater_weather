class Api::V1::ForecastController < ApplicationController

  def index
    forecast = WeatherFacade.get_weather_information(params[:location])
    if forecast != 0
      serialized_forecast = ForecastSerializer.new(forecast)
      render json: serialized_forecast
    else
      render json: {message: "There was an error getting the forecast for your search location"}, status: 400
    end
  end
end
