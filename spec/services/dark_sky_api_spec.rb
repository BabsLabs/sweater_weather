require 'rails_helper'

describe DarkSkyAPIService do
  it 'makes a Dark Sky API Service' do
    latitude_and_longitude = {:lat=>39.7392358, :lng=>-104.990251}

    dark_sky_api_service = DarkSkyAPIService.new(latitude_and_longitude)

    expect(dark_sky_api_service).to be_a DarkSkyAPIService
  end
  it "can return the forecast for the given latitude and longitude", :vcr do
    latitude_and_longitude = {:lat=>39.7392358, :lng=>-104.990251}

    dark_sky_api_service = DarkSkyAPIService.new(latitude_and_longitude)

    expect(dark_sky_api_service.get_forecast).to have_key(:currently)
    expect(dark_sky_api_service.get_forecast).to have_key(:daily)
  end
end