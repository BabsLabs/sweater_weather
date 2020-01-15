require 'rails_helper'

describe GoogleAPIService do
  it 'makes and instance of a GoogleAPIService', :vcr do
    google_api_service = GoogleAPIService.new

    expect(google_api_service).to be_a GoogleAPIService
  end

  it 'can get the latitude and longitude from a location', :vcr do
    location = 'denver, co'

    expect(GoogleAPIService.get_latitude_and_longitude(location)).to have_key :results
    expect(GoogleAPIService.get_latitude_and_longitude(location)[:results]).to be_an Array
  end

  it 'can get the city name from a latitude and longitude', :vcr do
    lat_and_long = {:lat=>-22.3193039, :long=>-65.8306389}

    expect(GoogleAPIService.get_city_name(lat_and_long)).to have_key(:results)
    expect(GoogleAPIService.get_city_name(lat_and_long)).to have_key(:plus_code)
    expect(GoogleAPIService.get_city_name(lat_and_long)[:results]).to be_an Array
    expect(GoogleAPIService.get_city_name(lat_and_long)[:results][0]).to have_key :address_components
    expect(GoogleAPIService.get_city_name(lat_and_long)[:results][0][:address_components]).to be_an Array
    expect(GoogleAPIService.get_city_name(lat_and_long)[:results][0][:address_components][0]).to have_key :long_name
  end
end