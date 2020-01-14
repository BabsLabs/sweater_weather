require 'rails_helper'

describe 'Users API Endpoints' do
  describe 'for a given user' do
    it 'returns the api key for a newly created user', :vcr do
      post "/api/v1/users", params: {email: 'email@email.com', password: 'password', password_confirmation: 'password_confirmation'}

      expect(response).to be_successful
      expect(User.last.email).to eq('email@email.com')
      expect(User.last.password_digest).to_not be_nil
      expect(User.last.api_key).to_not be_nil

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:api_key]).to eq(User.last.api_key)
    end
  end
end