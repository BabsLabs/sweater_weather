class WeatherFacadeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :weather_information
end
