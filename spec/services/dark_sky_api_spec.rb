require 'rails_helper'

describe DarkSkyAPIService do
  it 'makes a Dark Sky API Service', :vcr do
    dark_sky_api_service = DarkSkyAPIService.new

    expect(dark_sky_api_service).to be_a DarkSkyAPIService
  end

  it "can return the forecast for the given latitude and longitude", :vcr do
    latitude_and_longitude = {:lat=>39.7392358, :lng=>-104.990251}

    forecast_results = DarkSkyAPIService.get_forecast(latitude_and_longitude)

    expect(forecast_results).to have_key(:latitude)
    expect(forecast_results).to have_key(:longitude)
    expect(forecast_results).to have_key(:timezone)
    expect(forecast_results).to have_key(:currently)
    expect(forecast_results[:currently]).to have_key(:time)
    expect(forecast_results[:currently]).to have_key(:summary)
    expect(forecast_results[:currently]).to have_key(:icon)
    expect(forecast_results[:currently]).to have_key(:precipProbability)
    expect(forecast_results[:currently]).to have_key(:temperature)
    expect(forecast_results[:currently]).to have_key(:apparentTemperature)
    expect(forecast_results[:currently]).to have_key(:humidity)
    expect(forecast_results[:currently]).to have_key(:uvIndex)
    expect(forecast_results[:currently]).to have_key(:visibility)
    expect(forecast_results[:hourly]).to have_key(:summary)
    expect(forecast_results[:hourly]).to have_key(:icon)
    expect(forecast_results[:hourly]).to have_key(:data)
    expect(forecast_results[:hourly][:data]).to be_an Array
    expect(forecast_results[:hourly][:data][0]).to have_key(:time)
    expect(forecast_results[:hourly][:data][0]).to have_key(:temperature)
    expect(forecast_results[:daily]).to have_key(:summary)
    expect(forecast_results[:daily]).to have_key(:icon)
    expect(forecast_results[:daily]).to have_key(:data)
    expect(forecast_results[:daily][:data]).to be_an Array
    expect(forecast_results[:daily][:data][0]).to have_key(:time)
    expect(forecast_results[:daily][:data][0]).to have_key(:icon)
    expect(forecast_results[:daily][:data][0]).to have_key(:temperatureHigh)
    expect(forecast_results[:daily][:data][0]).to have_key(:temperatureLow)
    expect(forecast_results[:daily][:data][0]).to have_key(:precipProbability)
  end
end