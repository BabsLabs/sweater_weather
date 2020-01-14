require 'rails_helper'

describe Antipode do
  it 'makes and instance of a Antipode', :vcr do
    input = File.read("spec/fixtures/antipode_weather_response.json")
    weather_json = JSON.parse(input, symbolize_names: true)
    search_location = 'hong kong'
    antipode_info = 'Ruta Provincial 69 Yavi Jujuy Argentina'


    antipode = Antipode.new(weather_json, antipode_info, search_location)
    antipod_info = antipode.format_forecast_info(weather_json)

    expect(antipode).to be_an Antipode
    expect(antipod_info).to have_key(:summary)
    expect(antipod_info).to have_key(:current_temperature)
    expect(antipod_info).to_not have_key(:temperature)
  end
end