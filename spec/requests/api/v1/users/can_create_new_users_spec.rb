require 'rails_helper'

describe 'Users Endpoint' do
  describe 'for a given user' do
    it 'returns the api key for a newly created user', :vcr do
      post "/api/v1/users", params: {email: 'email@email.com', password: 'password', password_confirmation: 'password'}

      expect(response).to be_successful
      expect(User.last.email).to eq('email@email.com')
      expect(User.last.password_digest).to_not be_nil
      expect(User.last.api_key).to_not be_nil

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data][:attributes][:api_key]).to eq(User.last.api_key)
    end

    it 'returns shows an error if email was not provided', :vcr do
      post "/api/v1/users", params: {email: '', password: 'password', password_confirmation: 'password'}

      expect(response).to_not be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq({:message=>"Email can't be blank"})
    end

    it 'returns shows an error if password was not provided', :vcr do
      post "/api/v1/users", params: {email: 'email@email.com', password: '', password_confirmation: 'password'}

      expect(response).to_not be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq({:message=>"Password can't be blank"})
    end

    it 'returns shows an error if a user tried to use the same email', :vcr do
      User.create(email: 'email@email.com', password: 'password', password_confirmation: 'password')
      post "/api/v1/users", params: {email: 'email@email.com', password: 'password', password_confirmation: 'password'}

      expect(response).to_not be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq({:message=>"Email has already been taken"})
    end
  end
end