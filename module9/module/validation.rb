module Validation
  class << self
    def included(case)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end
  end

  module ClassMethods
    def validate(attr_name, validation_type, options = {})
    end


  end

  module InstanceMethods
    def validate!(validations)
      validations.each do |validation|
      
      end
    end


    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def presence(attr_name)
      raise 'Attribute cannot be nill or empty' if attr_empty? && attr_name.is_a?(String)
      raise 'Array cannot be empty' if attr_name.count.zero? && attr_name.is_a?(Array)
    end

    def format(attr_name, regex)
      raise 'Wrong format was passed' if attr_name !~ regex
    end

    def type(attr_name, class_name)
      raise "This attribute does not correspont to #{class_name}.to_s" unless class_name.include?(attr_name)
    end

    def attr_empty?(attr_name)
      attr_name.nil? && attr_name.to_s.strip.empty?
    end

    def get_instance_by_attr_name(name)
      instance_variable_get("@{name}".to_s)
    end
  end
end
