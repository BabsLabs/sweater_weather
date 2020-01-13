require 'rails_helper'

describe AntipodeWeatherFacade do
  it 'makes and instance of a AntipodeWeatherFacade', :vcr do
    input = File.read("spec/fixtures/antipode_weather_response.json")
    json = JSON.parse(input, symbolize_names: true)

    weather = AntipodeWeatherFacade.new(json)

    expect(weather).to be_a AntipodeWeatherFacade
    expect(weather.current_weather).to have_key(:summary)
    expect(weather.current_weather).to have_key(:current_temperature)
    expect(weather.current_weather).to_not have_key(:temperature)
  end
end