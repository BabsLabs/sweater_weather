class Api::V1::RoadTripController < ApplicationController

  def show
    if !params[:api_key] || !User.find_by(api_key: params[:api_key])
      render json: {message: 'Did you provide a correct api key?'}, status: 401
    elsif
      all_directions = get_all_direction_info(params[:origin], params[:destination])
      drive_time_string = get_drive_time_string(all_directions)
      drive_time_in_seconds = get_drive_time_seconds(all_directions)
      arrival_time = get_arrival_time_in_seconds(all_directions, drive_time_in_seconds)
      lat_and_long_of_destination = get_lat_and_long_of_destination(all_directions)
      forecast_results = get_forecast_results(lat_and_long_of_destination)
      hourly_arrival_forecast = get_hourly_forecast_data(forecast_results)
      temp_and_summary_on_arrival = get_current_weather_on_arrival_info(hourly_arrival_forecast, arrival_time)


      trip = Trip.new(temp_and_summary_on_arrival, drive_time_string, params[:origin], params[:destination])
      serialized_trip = TripSerializer.new(trip)

      render json: serialized_trip
    end
  end

  private

    def get_all_direction_info(origin, destination)
      GoogleAPIService.get_driving_directions(origin, destination)
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

    def get_hourly_forecast_data(forecast_results)
      forecast_results[:hourly][:data]
    end

    def get_current_weather_on_arrival_info(hourly_arrival_forecast, arrival_time)
      hourly_arrival_forecast.select do |h|
        h[:time] >= arrival_time
      end.first
      hourly_arrival_forecast[0].slice(:summary, :temperature)
    end

end