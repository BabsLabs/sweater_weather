require 'securerandom'

class UnsplashAPIService

  def self.get_background_photo_url(location)
    response = conn.get('search/photos') do |req|
      req.params['query'] = location
      req.params['per_page'] = 1
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  private

    attr_reader :location

    def self.conn
      Faraday.new(url: 'https://api.unsplash.com/') do |f|
        f.params['client_id'] = ENV['UNSPLASH_API_KEY']
        f.adapter Faraday.default_adapter
      end
    end

end