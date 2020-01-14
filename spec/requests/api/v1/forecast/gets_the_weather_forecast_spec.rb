require 'rails_helper'

describe 'Forecast Endpoint' do
  describe 'for a given location' do
    it ' gets the weather forecast info for the front end', :vcr do

      search_location = 'denver,co'

      get "/api/v1/forecast?location=#{search_location}"

      expect(response).to be_successful
    end
  end
end