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

  it 'can get the city name from a latitude and longitude', :vcr do
    lat_and_long = {:lat=>-22.3193039, :long=>-65.8306389}
    google_api_service = GoogleAPIService.new(nil, lat_and_long)

    expect(google_api_service.city_name_from_lat_and_long).to eq("Yavi")
  end
end