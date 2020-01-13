class AntipodeService
  attr_reader :antipode_info

  def initialize(latitude_and_longitude)
    @latitude = latitude_and_longitude[:lat]
    @longitude = latitude_and_longitude[:lng]
    @antipode_info = get_antipode
  end

  def get_antipode
    response = conn.get("antipodes") do |req|
      req.params['lat'] = @latitude
      req.params['long'] = @longitude
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  private

    def conn
      Faraday.new(url: 'http://amypode.herokuapp.com/api/v1/') do |f|
        f.headers['api_key'] = ENV['ANTIPODE_API_KEY']
        f.adapter Faraday.default_adapter
      end
    end

end