class ForecastFacade


  def initialize(forecast_info)
    @current_forecast = current_forecast(forecast_info)
    @eight_hour_forecast = eight_hour_forecast(forecast_info)
  end

  def current_forecast(forecast_info)
    current_forecast = CurrentWeather.new(forecast_info)
  end

end