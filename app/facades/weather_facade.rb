require 'securerandom'

class WeatherFacade

  attr_reader :weather_information, :id

  def initialize(location)
    @weather_information = get_weather_information(location)
    @id = SecureRandom.hex(10).to_s
  end

  private

    def get_weather_information(location)
      google_service = GoogleAPIService.new

      dark_sky_service = DarkSkyAPIService.new(google_service.get_latitude_and_longitude(location))

      ForecastFacade.new(dark_sky_service.get_forecast)
    end

end