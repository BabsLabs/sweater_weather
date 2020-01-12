class EightHourForecast
  attr_reader :eight_hour_weather

    def initialize(forecast_info)
      @eight_hour_weather = eight_hour_info(forecast_info)
    end

    private

    def eight_hour_info(forecast_info)
      array = []
      forecast_info[:hourly][:data].each do |data|
        if data[:time] >= forecast_info[:currently][:time]
          array << cleaner(data)
        end
      end
      array.take(8)
    end

    def cleaner(weather_data)
      weather_data.select {|k,v| [:time, :temperature].include?(k) }
    end


end