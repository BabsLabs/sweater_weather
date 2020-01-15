class DarkSkyAPIService

  def self.get_forecast(latitude_and_longitude)
    response = conn.get("/forecast/#{ENV['DARK_SKY_API_KEY']}/#{latitude_and_longitude[:lat]},#{latitude_and_longitude[:lng] || latitude_and_longitude[:long]}") do |req|
      req.params['exclude'] = 'minutely,flags'
      req.params['units'] = 'us'
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  private

  attr_reader :latitude, :longitude

    def self.conn
      Faraday.new(url: 'https://api.darksky.net') do |f|
        f.adapter Faraday.default_adapter
      end
    end

end