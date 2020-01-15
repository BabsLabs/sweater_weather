require 'rails_helper'

describe UnsplashAPIService do
  it 'makes a UnsplashAPIService', :vcr do
    unsplash_api_service = UnsplashAPIService.new

    expect(unsplash_api_service).to be_a UnsplashAPIService
  end

  it "can return the photo for the given location", :vcr do
    location = "denver,co"

    expect(UnsplashAPIService.get_background_photo_url(location)).to have_key :results
    expect(UnsplashAPIService.get_background_photo_url(location)[:results]).to be_an Array
    expect(UnsplashAPIService.get_background_photo_url(location)[:results][0][:urls]).to have_key :raw
  end
end