require 'rails_helper'

describe 'Backgrounds  Endpoint' do
  describe 'for a given location' do
    it ' gets the weather forecast info for the front end', :vcr do

      search_location = 'denver,co'

      get "/api/v1/backgrounds?location=#{search_location}"

      expect(response).to be_successful
      expect(response.body).to be_a String
    end
  end
end