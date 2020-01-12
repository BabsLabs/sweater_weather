require 'rails_helper'

describe GoogleAPIService do
  it 'makes and instance of a GoogleAPIService', :vcr do
    location = 'denver, co'
    google_api_service = GoogleAPIService.new(location)

    expect(google_api_service).to be_a GoogleAPIService
  end

  it 'can get the latitude and longitude from a location', :vcr do
    location = 'denver, co'
    google_api_service = GoogleAPIService.new(location)

    expect(google_api_service.latitude_and_longitude).to eq({:lat=>39.7392358, :lng=>-104.990251})
  end
end