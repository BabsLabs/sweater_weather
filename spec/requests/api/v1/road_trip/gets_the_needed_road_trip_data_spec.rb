require 'rails_helper'

describe 'RoadTrip Endpoint' do
  describe 'for a given user' do
    it 'returns the road trip information', :vcr do

      WebMock.enable_net_connect!
      VCR.eject_cassette
      VCR.turn_off!(ignore_cassettes: true)

      User.create(email: 'email@email.com', password: 'password', password_confirmation: 'password', api_key: "jgn983hy48thw9begh98h4539h4")
      good_params = { "origin": "Denver,CO", "destination": "Pueblo,CO", "api_key": "jgn983hy48thw9begh98h4539h4" }
      post "/api/v1/road_trip", params: good_params

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to have_key :data
    end

    it 'returns an error if api_key was not provided or was provided wrong', :vcr do
      User.create(email: 'email@email.com', password: 'password', password_confirmation: 'password')
      good_params = { "origin": "Denver,CO", "destination": "Pueblo,CO", "api_key": "jgn983hy48thw9begh98h4539h4" }
      post "/api/v1/road_trip", params: good_params

      expect(response).to_not be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq({:message=>"Did you provide a correct api key?"})
    end
  end
end