class TripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :temp_and_summary_on_arrival, :drive_time, :origin, :destination
end
