require 'securerandom'

class AntipodeFacade
  attr_reader :get_info

  def initialize(location)
    @location = location
    @get_info = format_info(location)
  end

    def format_info(location)
      location = GoogleAPIService.new(location, nil)
      antipode = AntipodeService.new(location.latitude_and_longitude)
      antipode_info_for_google_reverse_lookup = antipode.antipode_info[:data][:attributes]
      antipode_city_info = GoogleAPIService.new(nil , antipode_info_for_google_reverse_lookup)
      # reassign the key returned from the antipode service to be reused in the darksky service
      # break out into its own method or refactor in the final facade if there is time
      # antipode_info_for_google_reverse_lookup[:lng] = antipode_info_for_google_reverse_lookup[:long]
      forecast_results = DarkSkyAPIService.new(antipode_info_for_google_reverse_lookup)
      antipode_weather_facade = AntipodeWeatherFacade.new(forecast_results.forecast_info)
      # binding.pry

      { "data": [
        { "id": 1},
        "type":"antipode",
        "attributes": {
          "location_name":"#{antipode_city_info.city_name_from_lat_and_long}",
          "forecast": antipode_weather_facade.current_weather,
           "search_location": "#{@location.capitalize}"
        }
        ]}
    end

end