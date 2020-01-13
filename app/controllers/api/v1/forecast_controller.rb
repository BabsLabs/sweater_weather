class Api::V1::ForecastController < ApplicationController

  def index
    weather_facade = WeatherFacade.new(params[:location])
    # serialized_weather = WeatherFacadeSerializer.new(weather_facade)

    render json: weather_facade
  end

end