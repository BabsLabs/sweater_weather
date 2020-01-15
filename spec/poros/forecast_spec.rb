require 'rails_helper'

describe Forecast do
  it 'makes and instance of a Forecast' do
    weather_json = File.read('spec/fixtures/weather_response.json')
    parsed_weather = JSON.parse(weather_json, symbolize_names: true)

    forecast = Forecast.new(parsed_weather)

    expect(forecast).to be_a Forecast
  end
end
