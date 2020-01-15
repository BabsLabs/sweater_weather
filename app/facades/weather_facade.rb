require 'securerandom'

class WeatherFacade

  attr_reader :weather_information, :id

  def initialize(location)
    @weather_information = get_weather_information(location)
    @id = SecureRandom.hex(10).to_s
  end

  private

    def get_weather_information(location)
      # location_lat_and_long = GoogleAPIService.new(location)
      google_service = GoogleAPIService.new

      location_lat_and_long = google_service.get_latitude_and_longitude(location)

      lat_and_long_for_darksky = location_lat_and_long[:results][0][:geometry][:location]

      dark_sky_service = DarkSkyAPIService.new(lat_and_long_for_darksky)

      forecast = dark_sky_service.get_forecast

      ForecastFacade.new(forecast)
    end

end