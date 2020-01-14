class Api::V1::RoadTripController < ApplicationController

  def show
    if !params[:api_key] || !(user = User.find_by(api_key: params[:api_key]))
      render json: {message: 'Did you provide a correct api key?'}, status: 401
    elsif
      google_service = GoogleAPIService.new
      directions = google_service.get_driving_directions(params[:origin], params[:destination])
      drive_time = directions[:routes][0][:legs][0][:duration][:text]
      lat_and_long_of_destination = directions[:routes][0][:legs][0][:end_location]
      dark_sky_service = DarkSkyAPIService.new(lat_and_long_of_destination)
      forecast_results = dark_sky_service.get_forecast

      hourly_arrival_forecast = forecast_results[:hourly][:data]

      array = []
      hourly_arrival_forecast.each do |hourly_info|
        binding.pry
        #remove the letters and spaces from the drive time and make it an int
        arrival_time = hourly_info[:time] + drive_time.delete("^0-9").to_i

      end


    end
  end

end