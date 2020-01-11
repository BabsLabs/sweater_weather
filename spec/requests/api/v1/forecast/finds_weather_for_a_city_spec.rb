require 'rails_helper'

describe "Forecast API Endpoints" do
  describe "it finds the weather for a city" do
    it " pulls out the city and state from the get request and send it to Googles Geocoding API", :vcr do

      WebMock.enable_net_connect!
      VCR.eject_cassette
      VCR.turn_off!(ignore_cassettes: true)

      city = "denver"
      state = "co"

      get "/api/v1/forecast?location=#{city},#{state}"

      expect(response).to be_successful
    end
  end
end