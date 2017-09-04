
module Validation
  class << self
    def included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end
  end

  module ClassMethods
    attr_accessor :validation_hash
    # validation_hash = {name: [{presense: name}, {format: 'w'}, {type: string}]}

    def validate(attr_name, validation_type, options = "")
     validation_array ||= []
     @validation_hash ||= {}
     validation_array << { validation_type => options}
     @validation_hash[attr_name.to_sym] = validation_array
     puts "#{validation_hash}"
    end
  end

  module InstanceMethods
    def validate!

      self.class.validation_hash.each do |attr_name, array|
      instance = get_instance_by_attr_name(attr_name)
      array.each do |hash|
        hash.each{|type, value|send(type, instance, value)}
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
      raise 'Attribute cannot be nill or empty' if attr_name.empty? && attr_name.is_a?(String)
      raise 'Array cannot be empty' if attr_name.count.zero? && attr_name.is_a?(Array)
    end

    def format(attr_name, value_format)
      raise 'Wrong format was passed' if attr_name !~ value_format
    end

    def type(attr_name, class_name)
      raise "This attribute does not correspont to #{class_name}" unless attr_name.is_a?(class_name)
    end

    def attr_empty?(attr_name)
      attr_name.nil? && attr_name.to_s.strip.empty?
    end

    def get_instance_by_attr_name(name)
      instance_variable_get("@#{name}")
    end
  end
end
