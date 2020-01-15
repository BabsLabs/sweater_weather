class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current_forecast, :eight_hour_forecast, :five_day_forecast
end
