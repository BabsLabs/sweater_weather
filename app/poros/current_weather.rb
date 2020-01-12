class CurrentWeather
  attr_reader :current_temperature,
              :current_weather_icon,
              :current_weather_summary,
              :todays_high,
              :todays_low,
              :feels_like,
              :humidity,
              :visibility,
              :uv_index

  def initialize(forecast_info)
    @current_temperature = forecast_info[:currently][:temperature].to_i
    @current_weather_icon = forecast_info[:currently][:icon]
    @current_weather_summary = forecast_info[:currently][:summary]
    @todays_high = forecast_info[:daily][:data][0][:temperatureHigh].to_i
    @todays_low = forecast_info[:daily][:data][0][:temperatureLow].to_i
    @feels_like = forecast_info[:currently][:apparentTemperature].to_i
    @humidity = forecast_info[:currently][:humidity].to_i
    @visibility = forecast_info[:currently][:visibility]
    @uv_index = forecast_info[:currently][:uvIndex].to_i
  end

end