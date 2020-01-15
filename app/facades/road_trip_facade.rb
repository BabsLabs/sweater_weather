class RoadTripFacade

  def initialize(info)
    @origin = info[:origin]
    @destination = info[:destination]
  end

  def make_road_trip
    all_directions = get_all_direction_info(origin, destination)

    drive_time_info = get_travel_time_info(all_directions)

    arrival_time = get_arrival_time_in_seconds(all_directions, drive_time_info.travel_time_seconds)

    hourly_arrival_forecast = get_arrival_forecast(all_directions)

    temp_and_summary_on_arrival = get_current_weather_on_arrival_info(hourly_arrival_forecast, arrival_time)

    Trip.new(temp_and_summary_on_arrival, drive_time_info.travel_time_string, origin, destination)
  end

  private

    attr_reader :origin, :destination

    def get_all_direction_info(origin, destination)
      GoogleAPIService.get_driving_directions(origin, destination)
    end


    def get_drive_time_string(all_directions)
      all_directions[:routes][0][:legs][0][:duration][:text]
    end

    def get_drive_time_seconds(all_directions)
      all_directions[:routes][0][:legs][0][:duration][:value]
    end

    def get_travel_time_info(all_directions)
      TravelTimes.new(get_drive_time_string(all_directions), get_drive_time_seconds(all_directions))
    end

    def get_arrival_time_in_seconds(all_directions, drive_time_in_seconds)
      (Time.now + drive_time_in_seconds).to_i
    end

    def get_lat_and_long_of_destination(all_directions)
      all_directions[:routes][0][:legs][0][:end_location]
    end

    def get_forecast_results(lat_and_long_of_destination)
      DarkSkyAPIService.get_forecast(lat_and_long_of_destination)
    end

    def get_hourly_arrival_forecast(lat_and_long_of_destination)
      forecast_results = get_forecast_results(lat_and_long_of_destination)
      forecast_results[:hourly][:data]
    end

    def get_arrival_forecast(all_directions)
      lat_and_long_of_destination = get_lat_and_long_of_destination(all_directions)
      get_hourly_arrival_forecast(lat_and_long_of_destination)
    end

    def get_current_weather_on_arrival_info(hourly_arrival_forecast, arrival_time)
      hourly_arrival_forecast.select do |h|
        h[:time] >= arrival_time
      end.first
      hourly_arrival_forecast[0].slice(:summary, :temperature)
    end
end