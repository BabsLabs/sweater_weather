class AntipodeWeatherFacade
  attr_reader :current_weather

  def initialize(forecast_info)
    @current_weather = format_forecast_info(forecast_info)
  end

  private

    def format_forecast_info(forecast_info)
      current_info = forecast_info[:currently]
      current_info.slice(:summary, :temperature)
    end

end