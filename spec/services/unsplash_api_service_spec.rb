require 'rails_helper'

describe UnsplashAPIService do
  it 'makes a UnsplashAPIService', :vcr do
    location = "denver,co"

    unsplash_api_service = UnsplashAPIService.new(location)

    expect(unsplash_api_service).to be_a UnsplashAPIService
  end

  it "can return the photo for the given location", :vcr do
    location = "denver,co"

    unsplash_api_service = UnsplashAPIService.new(location)

    expect(unsplash_api_service.get_background_photo_url).to be_a String
  end
end