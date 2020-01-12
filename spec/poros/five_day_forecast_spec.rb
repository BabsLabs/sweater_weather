require 'rails_helper'

describe FiveDayForecast do
  it 'makes and instance of a FiveDayForecast' do
    weather_json = File.read('spec/fixtures/weather_response.json')
    parsed_weather = JSON.parse(weather_json, symbolize_names: true)

    forecast = FiveDayForecast.new(parsed_weather)

    expect(forecast).to be_a FiveDayForecast
  end

  it 'can find the weather for the next eight hours' do
    weather_json = File.read('spec/fixtures/weather_response.json')
    parsed_weather = JSON.parse(weather_json, symbolize_names: true)

    five_day_forecast = FiveDayForecast.new(parsed_weather)

    expect(five_day_forecast.five_day_weather).to be_an Array
    expect(five_day_forecast.five_day_weather.count).to eq(5)
    expect(five_day_forecast.five_day_weather[0]).to be_a Hash
    expect(five_day_forecast.five_day_weather[0]).to have_key :time
    expect(five_day_forecast.five_day_weather[0]).to have_key :summary
    expect(five_day_forecast.five_day_weather[0]).to have_key :icon
    expect(five_day_forecast.five_day_weather[0]).to have_key :temperatureHigh
    expect(five_day_forecast.five_day_weather[0]).to have_key :temperatureLow
    expect(five_day_forecast.five_day_weather[0]).to have_key :precipProbability
    expect(five_day_forecast.five_day_weather[0]).to_not have_key :precipIntensityMax
  end
end