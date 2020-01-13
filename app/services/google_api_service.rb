class GoogleAPIService
  attr_reader :latitude_and_longitude, :city_name_from_lat_and_long

  def initialize(location_name = nil, lat_and_long = nil )
    @latitude_and_longitude = get_latitude_and_longitude(location_name) if location_name != nil
    @city_name_from_lat_and_long = get_city_name(lat_and_long) if lat_and_long != nil
  end

  private

    def get_latitude_and_longitude(location)
      response = conn.get('/maps/api/geocode/json') do |req|
        req.params['address'] = location
      end

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      # returns the hash of latitude and longitude
      parsed_response[:results].first[:geometry][:location]
    end


    def get_city_name(lat_and_long)
      response = conn.get('/maps/api/geocode/json') do |req|
        req.params['latlng'] = "#{lat_and_long[:lat]}, #{lat_and_long[:long]}"
      end

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      parsed_response[:results][0][:address_components][1][:long_name]
    end

    def conn
      Faraday.new(url: 'https://maps.googleapis.com') do |f|
        f.params['key'] = ENV['GOOGLE_GEOCODE_API_KEY']
        f.adapter Faraday.default_adapter
      end
    end
end
