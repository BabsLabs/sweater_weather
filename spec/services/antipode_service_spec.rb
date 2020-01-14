require 'rails_helper'

describe AntipodeService do
  it 'makes a Antipode Service', :vcr do
    latitude_and_longitude = {:lat=>22.3193039, :lng=>114.1693611}

    antipode_service = AntipodeService.new(latitude_and_longitude)

    expect(antipode_service).to be_a AntipodeService
  end

  it "can return the forecast for the given latitude and longitude", :vcr do
    latitude_and_longitude = {:lat=>22.3193039, :lng=>114.1693611}

    antipode_service = AntipodeService.new(latitude_and_longitude)

    expect(antipode_service.antipode_info).to have_key(:data)
    expect(antipode_service.antipode_info[:data]).to have_key(:id)
    expect(antipode_service.antipode_info[:data]).to have_key(:type)
    expect(antipode_service.antipode_info[:data]).to have_key(:attributes)
    expect(antipode_service.antipode_info[:data][:attributes]).to have_key(:lat)
    expect(antipode_service.antipode_info[:data][:attributes]).to have_key(:long)
  end
end