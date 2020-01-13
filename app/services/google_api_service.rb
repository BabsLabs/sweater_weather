class GoogleAPIService
  attr_reader :latitude_and_longitude

  def initialize(location)
    @latitude_and_longitude = get_latitude_and_longitude(location)
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

    def conn
      Faraday.new(url: 'https://maps.googleapis.com') do |f|
        f.params['key'] = ENV['GOOGLE_GEOCODE_API_KEY']
        f.adapter Faraday.default_adapter
      end
    end
end
