module ValidateNumber
  protected
  VALID_NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i
  def validate_number! (number)
    raise "Number cannot be nil" if number.nil?
    raise "Number must be at least 5 characters" if number.to_s.length < 5
    raise "Number must have 3 letters and/or numbers,
           hypen(optional) and 2 letters and/or numbers" if number !~ VALID_NUMBER_FORMAT
    true
  end
end
