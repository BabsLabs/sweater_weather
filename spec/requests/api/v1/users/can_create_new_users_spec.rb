require 'rails_helper'

describe 'Users API Endpoints' do
  describe 'for a given user' do
    it 'returns the api key for a newly created user', :vcr do

      post "/api/v1/users"

      expect(response).to be_successful
    end
  end
end