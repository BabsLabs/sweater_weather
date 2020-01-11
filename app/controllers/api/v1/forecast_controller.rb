class Api::V1::ForecastController < ApplicationController

  def index
    location = params[:location]

    url = 'https://maps.googleapis.com/maps/api/geocode/json'
    response = Faraday.get(url) do |req|
      req.params['address'] = location
      req.params['key'] = ENV['GOOGLE_GEOCODE_API_KEY']
    end

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    # reutrns the hash of longitude and lattitude
    lat_and_long = parsed_response[:results].first[:geometry][:location]
  end

end