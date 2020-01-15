require 'securerandom'

class Forecast
  attr_reader :id, :current_forecast, :eight_hour_forecast, :five_day_forecast

  def initialize(forecast_info)
    @current_forecast = CurrentWeather.new(forecast_info)
    @eight_hour_forecast = EightHourForecast.new(forecast_info)
    @five_day_forecast = FiveDayForecast.new(forecast_info)
    @id = SecureRandom.hex(10)
  end

end