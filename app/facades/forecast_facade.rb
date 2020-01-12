class ForecastFacade
  attr_reader :current_forecast, :eight_hour_forecast

  def initialize(forecast_info)
    @current_forecast = current_info(forecast_info)
    @eight_hour_forecast = eight_hour_info(forecast_info)
    @five_day_forecast = five_day_info(forecast_info)
  end

  private

    def current_info(forecast_info)
      CurrentWeather.new(forecast_info)
    end

    def eight_hour_info(forecast_info)
      EightHourForecast.new(forecast_info)
    end

    def five_day_info(forecast_info)
      FiveDayForecast.new(forecast_info)
    end

end