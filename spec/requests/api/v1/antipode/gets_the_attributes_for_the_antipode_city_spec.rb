require 'rails_helper'

describe 'Antipode API Endpoint' do
  describe 'for a given location' do
    it ' gets the antipode city name and weather forecast', :vcr do
      search_location = 'hong kong'

      get "/api/v1/antipode?location=#{search_location}"

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to have_key(:data)
      expect(parsed_response[:data]).to have_key(:id)
      expect(parsed_response[:data]).to have_key(:type)
      expect(parsed_response[:data]).to have_key(:attributes)
      expect(parsed_response[:data][:attributes]).to have_key(:id)
      expect(parsed_response[:data][:attributes]).to have_key(:location_name)
      expect(parsed_response[:data][:attributes]).to have_key(:forecast)
      expect(parsed_response[:data][:attributes][:forecast]).to have_key(:summary)
      expect(parsed_response[:data][:attributes][:forecast]).to have_key(:current_temperature)
      expect(parsed_response[:data][:attributes]).to have_key(:search_location)

    end
  end
end