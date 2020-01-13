class WeatherFacade

  attr_reader :weather_information

  def initialize(location)
    @weather_information = get_weather_information(location)
  end

  private

    def get_weather_information(location)
      location_lat_and_long = GoogleAPIService.new(location)

      forecast_results = DarkSkyAPIService.new(location_lat_and_long.latitude_and_longitude)

      ForecastFacade.new(forecast_results.forecast_info)
    end

end