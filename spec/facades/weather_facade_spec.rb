require 'rails_helper'

describe WeatherFacade do
  it 'makes and instance of a WeatherFacade', :vcr do
    weather_facade = WeatherFacade.new

    expect(weather_facade).to be_a WeatherFacade
  end
end