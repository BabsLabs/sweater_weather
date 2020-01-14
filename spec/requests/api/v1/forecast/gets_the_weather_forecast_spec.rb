require 'rails_helper'

describe 'Forecast Endpoint' do
  describe 'for a given location' do
    it ' gets the weather forecast info for the front end', :vcr do

      search_location = 'denver,co'

      get "/api/v1/forecast?location=#{search_location}"

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to have_key :data
      expect(parsed_response[:data]).to have_key :id
      expect(parsed_response[:data]).to have_key :attributes
      expect(parsed_response[:data][:attributes]).to have_key :id
      expect(parsed_response[:data][:attributes]).to have_key :weather_information
      expect(parsed_response[:data][:attributes][:weather_information]).to have_key :current_forecast
      expect(parsed_response[:data][:attributes][:weather_information][:current_forecast]).to have_key :current_time
      expect(parsed_response[:data][:attributes][:weather_information][:eight_hour_forecast]).to have_key :eight_hour_weather
      expect(parsed_response[:data][:attributes][:weather_information][:eight_hour_forecast][:eight_hour_weather][0]).to have_key :time
      expect(parsed_response[:data][:attributes][:weather_information][:eight_hour_forecast][:eight_hour_weather][0]).to have_key :temperature
      expect(parsed_response[:data][:attributes][:weather_information][:five_day_forecast]).to have_key :five_day_weather
      expect(parsed_response[:data][:attributes][:weather_information][:five_day_forecast][:five_day_weather][0]).to have_key :time
      expect(parsed_response[:data][:attributes][:weather_information][:five_day_forecast][:five_day_weather][0]).to have_key :icon
      expect(parsed_response[:data][:attributes][:weather_information][:five_day_forecast][:five_day_weather][0]).to have_key :temperatureHigh
      expect(parsed_response[:data][:attributes][:weather_information][:five_day_forecast][:five_day_weather][0]).to have_key :temperatureLow
      expect(parsed_response[:data][:attributes][:weather_information][:five_day_forecast][:five_day_weather][0]).to have_key :precipProbability
    end
  end
end