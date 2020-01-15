require 'securerandom'

class AntipodeFacade

  def self.get_antipode_info(location)
    latitude_and_longitude_of_search_location = get_latitude_and_longitude_from_google(location)
    antipode_info = get_latitude_and_longitude_of_antipode(latitude_and_longitude_of_search_location)
    antipode_city_data = get_city_info(antipode_info)
    antipode_name_info = get_antipode_name(antipode_city_data)
    weather_data = get_forecast_from_darksky(antipode_info)
    Antipode.new(weather_data, antipode_name_info, location)
  end

  private

    def self.get_antipode_name(antipode_city_data)
      antipode_city_data[:results][0][:address_components].map do |address_piece|
        address_piece[:long_name]
      end.flatten.join(' ')
    end

    def self.get_latitude_and_longitude_from_google(location)
      google_service_results =  GoogleAPIService.get_latitude_and_longitude(location)

      #get just the needed lat and long from the google api results to pass into the AntipodeService
      google_service_results[:results].first[:geometry][:location]
    end

    def self.get_latitude_and_longitude_of_antipode(latitude_and_longitude_of_search_location)
      antipode_response = AntipodeService.get_antipode(latitude_and_longitude_of_search_location)

      #gets the lat and long of the antipode location from the returned results
      antipode_response[:data][:attributes]
    end

    def self.get_city_info(antipode_info)
      GoogleAPIService.get_city_name(antipode_info)
    end

    def self.get_forecast_from_darksky(antipode_info)
      DarkSkyAPIService.get_forecast(antipode_info)
    end

end