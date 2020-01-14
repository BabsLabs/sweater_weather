require 'rails_helper'

describe 'Sessions API Endpoints' do
  describe 'for a given user' do
    it 'returns the api key in a session when a user logs in', :vcr do
      user = User.create(email: 'email@email.com', password: 'password', password_confirmation: 'password')
      post "/api/v1/sessions", params: {email: 'email@email.com', password: 'password'}

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to have_key :api_key
      expect(parsed_response[:api_key]).to eq(user.api_key)
    end

    it 'returns shows an error if something was not provided', :vcr do
      User.create(email: 'email@email.com', password: 'password', password_confirmation: 'password')
      post "/api/v1/sessions", params: {email: 'email@email.com', password: ''}

      expect(response).to_not be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq({:message=>"Bad Credentials"})
    end
  end
end