require 'securerandom'

class Antipode
  attr_reader :id, :location_name, :forecast, :search_location

  def initialize(weather_data, antipode_name_info, search_location)
    @id = SecureRandom.hex(10)
    @location_name = antipode_name_info
    @forecast = format_forecast_info(weather_data)
    @search_location = search_location
  end

  private

    def format_forecast_info(weather_data)
      current_info = weather_data[:currently]
      sliced_forecast = current_info.slice(:summary, :temperature)
      sliced_forecast[:current_temperature] = sliced_forecast[:temperature]
      sliced_forecast.delete(:temperature)
      sliced_forecast
    end

end