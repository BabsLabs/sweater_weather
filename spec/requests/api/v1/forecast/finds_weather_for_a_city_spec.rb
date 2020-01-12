require 'rails_helper'

describe 'Forecast API Endpoints' do
  describe 'it finds the weather for a city' do
    it ' gets the wather for a given location' do

      search_location = 'denver,co'

      get "/api/v1/forecast?location=#{search_location}"

      expect(response).to be_successful

      expect(response.body).to eq({'data':'stuff'})
    end
  end


end