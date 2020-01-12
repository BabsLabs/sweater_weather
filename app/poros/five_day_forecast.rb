class FiveDayForecast
  attr_reader :five_day_weather

  def initialize(forecast_info)
    @five_day_weather = five_day_info(forecast_info)
  end

  private

    def five_day_info(forecast_info)
      five_days_of_info = forecast_info[:daily][:data].drop(1).take(5)
      cleaner(five_days_of_info)
    end

    def cleaner(weather_data)
      weather_data.map do |one_day_of_data|
        one_day_of_data.slice(:time, :icon, :summary, :temperatureHigh, :temperatureLow, :precipProbability)
      end
    end

end