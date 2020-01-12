require 'rails_helper'

describe ForecastFacade do
  it 'makes and instance of a Forecast' do

    weather_json = File.read('spec/fixtures/weather_response.json')
    parsed_weather = JSON.parse(weather_json, symbolize_names: true)

    forecast = ForecastFacade.new(parsed_weather)

    expect(forecast).to be_a ForecastFacade

  end


end