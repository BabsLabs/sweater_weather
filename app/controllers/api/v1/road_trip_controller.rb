class Api::V1::RoadTripController < ApplicationController
  before_action :validate

  def show
    road_trip_facade = RoadTripFacade.new(road_trip_params)
    road_trip = road_trip_facade.make_road_trip
    serialized_trip = TripSerializer.new(road_trip)
    render json: serialized_trip
  end

  private

    def road_trip_params
      params.permit(:origin, :destination)
    end

    def validate
      if !params[:api_key] || !User.find_by(api_key: params[:api_key])
        render json: {message: 'There was an error with your api_key. Did you provide a correct api key?'}, status: 401 and return
      end
    end
end