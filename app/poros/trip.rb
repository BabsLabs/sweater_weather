require 'securerandom'

class Trip
  attr_reader :id, :drive_time, :temp_and_summary_on_arrival, :origin, :destination

  def initialize(temp_and_summary_on_arrival, drive_time, origin, destination)
    @temp_and_summary_on_arrival = temp_and_summary_on_arrival
    @drive_time = drive_time
    @origin = origin
    @destination = destination
    @id = SecureRandom.hex(10)
  end

end