require 'rails_helper'

describe WeatherFacade do
  it 'makes and instance of a WeatherFacade', :vcr do

    location = 'denver,co'

    forecast = WeatherFacade.new(location)

    expect(forecast).to be_a WeatherFacade
  end
end