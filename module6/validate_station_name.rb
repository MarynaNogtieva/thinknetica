module ValidateStationName
  protected
  def validate_station_name!
    raise "Station name cannot be nil" if name.nil? || name.empty?
    raise "Station name should have 1 or more characters" if name.to_s.length < 1
    true
  end
end
