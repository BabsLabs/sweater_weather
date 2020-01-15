class EightHourForecast
  attr_reader :eight_hour_weather

  def initialize(forecast_info)
    @eight_hour_weather = eight_hour_info(forecast_info)
  end

  private

    def eight_hour_info(forecast_info)
      forecast_info[:hourly][:data].map do |day|
        day[:time] = Time.at(day[:time]).strftime("%Y-%b-%d %I:%M%p")
        day.slice(:time, :temperature)
      end.take(8)
    end

end
