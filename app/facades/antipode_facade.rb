require 'securerandom'

class AntipodeFacade

  def self.get_antipode_info(location)
    google_service = GoogleAPIService.new
    google_service_results =  google_service.get_latitude_and_longitude(location)

    #get just the needed lat and long from the google api results to pass into the AntipodeService
    latitude_and_longitude_of_search_location = google_service_results[:results].first[:geometry][:location]

    antipode_service = AntipodeService.new
    #gets the antipode lat and long
    antipode_response = antipode_service.get_antipode(latitude_and_longitude_of_search_location)

    #gets the lat and long of the antipode location from the returned results
    antipode_info_for_google_reverse_lookup = antipode_response[:data][:attributes]

    #gets the data for the antipode
    antipode_city_data = google_service.get_city_name(antipode_info_for_google_reverse_lookup)

    antipode_name_info = antipode_city_data[:results][0][:address_components].map {|address_piece| address_piece[:long_name]}.flatten.join(' ')

    darksky_service = DarkSkyAPIService.new(antipode_info_for_google_reverse_lookup)
    #get forecast  from the darksky service
    weather_data = darksky_service.get_forecast

    # make an antipode object to be returned and serialized
    antipode = Antipode.new(weather_data, antipode_name_info, location)

    serialized_antipode = AntipodeSerializer.new(antipode)
  end

end