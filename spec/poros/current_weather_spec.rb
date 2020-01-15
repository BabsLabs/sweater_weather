require 'rails_helper'

describe CurrentWeather do
  it 'makes and instance of a CurrentWeather' do
    weather_json = File.read('spec/fixtures/weather_response.json')
    parsed_weather = JSON.parse(weather_json, symbolize_names: true)

    forecast = CurrentWeather.new(parsed_weather)

    expect(forecast).to be_a CurrentWeather
  end

  it 'can find the data for the weather summary section' do
    weather_json = File.read('spec/fixtures/weather_response.json')
    parsed_weather = JSON.parse(weather_json, symbolize_names: true)

    current_weather = CurrentWeather.new(parsed_weather)

    expect(current_weather.current_time).to eq('2020-Jan-11 10:31PM')
    expect(current_weather.current_temperature).to eq(35)
    expect(current_weather.current_weather_icon).to eq('partly-cloudy-night')
    expect(current_weather.current_weather_summary).to eq('Partly Cloudy')
    expect(current_weather.todays_high).to eq(44)
    expect(current_weather.todays_low).to eq(23)
    expect(current_weather.feels_like).to eq(34)
    expect(current_weather.humidity).to eq(0)
    expect(current_weather.visibility).to eq(10.00)
    expect(current_weather.uv_index).to eq(0)
    expect(current_weather.today_summary).to eq("Clear throughout the day.")
    expect(current_weather.tonight_summary).to eq("Partly Cloudy")
  end
end