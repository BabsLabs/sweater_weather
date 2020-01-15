require 'securerandom'

class WeatherFacade

    def self.get_weather_information(location)
      google_data_for_search_location = get_search_location_data(location)
      lat_and_long_for_darksky = get_location_lat_and_long_for_search_location(google_data_for_search_location)

      if lat_and_long_for_darksky == 0
        return 0
      end

      forecast = get_forecast_info(lat_and_long_for_darksky)
      Forecast.new(forecast)
    end

    private

    def self.get_search_location_data(location)
      GoogleAPIService.get_latitude_and_longitude(location)
    end

    def self.get_location_lat_and_long_for_search_location(google_data_for_search_location)
      if google_data_for_search_location[:results] != []
        google_data_for_search_location[:results][0][:geometry][:location]
      else return 0
      end
    end

    def self.get_forecast_info(lat_and_long_for_darksky)
      DarkSkyAPIService.get_forecast(lat_and_long_for_darksky)
    end

end