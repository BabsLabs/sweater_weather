class TravelTimes
  attr_reader :travel_time_string, :travel_time_seconds

  def initialize(travel_time_string, travel_time_seconds)
    @travel_time_string = travel_time_string
    @travel_time_seconds = travel_time_seconds
  end
end