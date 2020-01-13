require 'rails_helper'

describe 'Antipode API Endpoint' do
  describe 'for a given location' do
    it ' gets the antipode city name and weather forecast', :vcr do
      search_location = 'hong kong'

      get "/api/v1/antipode?location=#{search_location}"

      expect(response).to be_successful


      expected_response = File.read('spec/fixtures/antipode_response.json')

      expect(response.body).to eq(expected_response)
    end
  end
end