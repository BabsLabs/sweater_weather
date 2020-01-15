class Api::V1::RoadTripController < ApplicationController

  def show
    if !params[:api_key] || !(user = User.find_by(api_key: params[:api_key]))
      render json: {message: 'Did you provide a correct api key?'}, status: 401
    elsif
      directions = GoogleAPIService.get_driving_directions(params[:origin], params[:destination])
      drive_time = directions[:routes][0][:legs][0][:duration][:text]

      drive_time_in_seconds = directions[:routes][0][:legs][0][:duration][:value]
      arrival_time = (Time.now + drive_time_in_seconds).to_i

      lat_and_long_of_destination = directions[:routes][0][:legs][0][:end_location]
      forecast_results = DarkSkyAPIService.get_forecast(lat_and_long_of_destination)

      hourly_arrival_forecast = forecast_results[:hourly][:data]

      forecast_on_arrival = hourly_arrival_forecast.select do |h|
        h[:time] >= arrival_time
      end.first

      temp_and_summary_on_arrival = forecast_on_arrival.slice(:summary, :temperature)

      trip = Trip.new(temp_and_summary_on_arrival, drive_time, params[:origin], params[:destination])

      serialized_trip = TripSerializer.new(trip)

      render json: serialized_trip
    end
  end

end