require 'rails_helper'

describe AntipodeService do
  it 'makes a Antipode Service', :vcr do
    antipode_service = AntipodeService.new

    expect(antipode_service).to be_a AntipodeService
  end

  it "can return the forecast for the given latitude and longitude", :vcr do
    latitude_and_longitude = {:lat=>22.3193039, :lng=>114.1693611}

    expect(AntipodeService.get_antipode(latitude_and_longitude)).to have_key(:data)
    expect(AntipodeService.get_antipode(latitude_and_longitude)[:data]).to have_key(:id)
    expect(AntipodeService.get_antipode(latitude_and_longitude)[:data]).to have_key(:type)
    expect(AntipodeService.get_antipode(latitude_and_longitude)[:data]).to have_key(:attributes)
    expect(AntipodeService.get_antipode(latitude_and_longitude)[:data][:attributes]).to have_key(:lat)
    expect(AntipodeService.get_antipode(latitude_and_longitude)[:data][:attributes]).to have_key(:long)
  end
end