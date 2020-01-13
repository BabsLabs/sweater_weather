class AntipodeWeatherFacade
  attr_reader :current_weather

  def initialize(forecast_info)
    @current_weather = format_forecast_info(forecast_info)
  end

  private

    def format_forecast_info(forecast_info)
      current_info = forecast_info[:currently]
      sliced_forecast = current_info.slice(:summary, :temperature)
      sliced_forecast[:current_temperature] = sliced_forecast[:temperature]
      sliced_forecast.delete(:temperature)
      sliced_forecast
    end

end