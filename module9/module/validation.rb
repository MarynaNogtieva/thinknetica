
module Validation
  class << self
    def included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end
  end

  module ClassMethods
    attr_reader :validation_hash, :validation_array
    # validation_hash = {name: [{presense: name}, {format: 'w'}, {type: string}]}

    def validate(attr_name, validation_type, options = {})
     @validation_array ||= []
     @validation_hash ||= {}
     validation_array << { validation_type => options}
     @validation_hash[attr_name.to_sym] = validation_array
    end
  end

  module InstanceMethods
    def validate!
      return if hash_empty?(self.class.validation_hash)
      self.class.validation_hash.each do |attr_name, array|
        instance = get_instance_by_attr_name(attr_name)
        array.each do |hash|
          hash.each{|type, options|send(type, instance, options)}
        end
      end
    end


    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def presence(attr_name, val)
      raise 'This value cannot be nil or empty' if attr_name.nil? || attr_name.empty?
    end

    def format(attr_name, options)
      options.each do |format, format_value|
        raise 'Wrong format was passed' if attr_name !~ format_value
      end
    end

    def type(attr_value, options)
      options.each do |item, class_name|
        raise "This attribute does not correspont to #{class_name}" unless attr_value.is_a?(class_name)
      end
    end

    def attr_empty?(attr_name)
      attr_name.nil? || attr_name.to_s.strip.empty?
    end

    def hash_empty?(hash)
      hash.nil? || hash.empty?
    end

    def get_instance_by_attr_name(name)
      instance_variable_get("@#{name}")
    end
  end
end
