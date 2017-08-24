module ValidateNumber
  protected

  def validate_number!
    raise "Number cannot be nil" if number.nil?
    raise "Number must be a positive number and greater than 0" if number < 1
    true
  end
end
