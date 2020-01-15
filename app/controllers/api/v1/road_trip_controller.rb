class Api::V1::RoadTripController < ApplicationController

  def show
    if !params[:api_key] || !User.find_by(api_key: params[:api_key])
      render json: {message: 'Did you provide a correct api key?'}, status: 401
    elsif User.find_by(api_key: params[:api_key])
      all_directions = get_all_direction_info(params[:origin], params[:destination])
      drive_time_info = get_travel_time_info(all_directions)
      arrival_time = get_arrival_time_in_seconds(all_directions, drive_time_info[1])
      lat_and_long_of_destination = get_lat_and_long_of_destination(all_directions)
      hourly_arrival_forecast = get_hourly_arrival_forecast(lat_and_long_of_destination)
      temp_and_summary_on_arrival = get_current_weather_on_arrival_info(hourly_arrival_forecast, arrival_time)

      render json: serialized_trip(temp_and_summary_on_arrival, drive_time_info[0], params[:origin], params[:destination])
    elsif
      render json: {message: 'There was an error. The most likely reason is your destination is further than 48 hours away. Please pick a stopping destination closer by.'}, status: 200
    end
  end

  private

    def get_all_direction_info(origin, destination)
      GoogleAPIService.get_driving_directions(origin, destination)
    end

    def get_travel_time_info(all_directions)
      travel_time_array = []
      travel_time_array[0] = get_drive_time_string(all_directions) if get_drive_time_string(all_directions) != 0
      travel_time_array[1] = get_drive_time_seconds(all_directions)
      travel_time_array
    end

    def get_drive_time_string(all_directions)
      all_directions[:routes][0][:legs][0][:duration][:text]
    end

    def get_drive_time_seconds(all_directions)
      all_directions[:routes][0][:legs][0][:duration][:value]
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

    def get_current_weather_on_arrival_info(hourly_arrival_forecast, arrival_time)
      hourly_arrival_forecast.select do |h|
        h[:time] >= arrival_time
      end.first
      hourly_arrival_forecast[0].slice(:summary, :temperature)
    end

    def serialized_trip(temp_and_summary_on_arrival, drive_time_string, origin, destination)
      trip = Trip.new(temp_and_summary_on_arrival, drive_time_string, origin, destination)
      TripSerializer.new(trip)
    end

end