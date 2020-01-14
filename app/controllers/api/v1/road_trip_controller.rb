class Api::V1::RoadTripController < ApplicationController

  def show
    if !params[:api_key] || !(user = User.find_by(api_key: params[:api_key]))
      render json: {message: 'Did you provide a correct api key?'}, status: 401
    elsif
      google_service = GoogleAPIService.new
      directions = google_service.get_driving_directions(params[:origin], params[:destination])
      drive_time = directions[:routes][0][:legs][0][:duration][:text]

      drive_time_in_seconds = directions[:routes][0][:legs][0][:duration][:value]
      arrival_time = (Time.now + drive_time_in_seconds).to_i

      lat_and_long_of_destination = directions[:routes][0][:legs][0][:end_location]
      dark_sky_service = DarkSkyAPIService.new(lat_and_long_of_destination)

      forecast_results = dark_sky_service.get_forecast

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