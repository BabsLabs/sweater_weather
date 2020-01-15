class AntipodeService

  def self.get_antipode(latitude_and_longitude)
    response = conn.get("antipodes") do |req|
      req.params['lat'] = latitude_and_longitude[:lat]
      req.params['long'] = latitude_and_longitude[:lng]
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  private

    def self.conn
      Faraday.new(url: 'http://amypode.herokuapp.com/api/v1/') do |f|
        f.headers['api_key'] = ENV['ANTIPODE_API_KEY']
        f.adapter Faraday.default_adapter
      end
    end

end