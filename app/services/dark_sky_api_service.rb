class DarkSkyAPIService
    attr_reader :forecast_info

  def initialize(latitude_and_longitude)
    @latitude = latitude_and_longitude[:lat]
    @longitude = latitude_and_longitude[:lng]
    @forecast_info = get_forecast
  end

  def get_forecast
    response = conn.get("/forecast/#{ENV['DARK_SKY_API_KEY']}/#{@latitude},#{@longitude}") do |req|
      req.params['exclude'] = 'minutely,flags'
      req.params['units'] = 'us'
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  private

    def conn
      Faraday.new(url: 'https://api.darksky.net') do |f|
        f.adapter Faraday.default_adapter
      end
    end

end