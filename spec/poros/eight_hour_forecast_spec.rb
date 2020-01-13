require 'rails_helper'

describe EightHourForecast do
  it 'makes and instance of a EightHourForecast' do
    weather_json = File.read('spec/fixtures/weather_response.json')
    parsed_weather = JSON.parse(weather_json, symbolize_names: true)

    forecast = EightHourForecast.new(parsed_weather)

    expect(forecast).to be_a EightHourForecast
  end

  it 'can find the weather for the next eight hours' do
    weather_json = File.read('spec/fixtures/weather_response.json')
    parsed_weather = JSON.parse(weather_json, symbolize_names: true)

    eight_hour_forecast = EightHourForecast.new(parsed_weather)

    expect(eight_hour_forecast.eight_hour_weather).to be_an Array
    expect(eight_hour_forecast.eight_hour_weather.count).to eq(8)
    expect(eight_hour_forecast.eight_hour_weather[0]).to be_a Hash
    expect(eight_hour_forecast.eight_hour_weather[0]).to have_key :time
    expect(eight_hour_forecast.eight_hour_weather[0]).to have_key :temperature
    expect(eight_hour_forecast.eight_hour_weather[0]).to_not have_key :cloudCover
  end
end