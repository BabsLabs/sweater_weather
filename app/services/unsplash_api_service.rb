require 'securerandom'

class UnsplashAPIService
  attr_reader :id

  def initialize(location)
    @location = location
    @id = SecureRandom.hex(10).to_s
  end

  def get_background_photo_url
    response = conn.get('search/photos') do |req|
      req.params['query'] = location
      req.params['per_page'] = 1
    end

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    parsed_response[:results][0][:urls][:raw]
  end

  private

    attr_reader :location

    def conn
      Faraday.new(url: 'https://api.unsplash.com/') do |f|
        f.params['client_id'] = ENV['UNSPLASH_API_KEY']
        f.adapter Faraday.default_adapter
      end
    end

end