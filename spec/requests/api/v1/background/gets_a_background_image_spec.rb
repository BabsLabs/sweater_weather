require 'rails_helper'

describe 'Backgrounds  Endpoint' do
  describe 'for a given location' do
    it ' gets the weather forecast info for the front end', :vcr do

      search_location = 'denver,co'

      get "/api/v1/backgrounds?location=#{search_location}"

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to have_key :data
      expect(parsed_response[:data]).to have_key :id
      expect(parsed_response[:data]).to have_key :type
      expect(parsed_response[:data]).to have_key :attributes
      expect(parsed_response[:data][:attributes]).to have_key :id
      expect(parsed_response[:data][:attributes]).to have_key :url
    end
  end
end