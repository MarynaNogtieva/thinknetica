module Acessors
  class << self
    def included(base)
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def  attr_accessor_with_history(*methods)
      methods.each do |method|
        #getter for method
        method_name = method.to_sym
        define_method("#{method_name}") do
          instance_variable_get("@#{method_name}")
        end

       #setter for method
        define_method("#{method_name}=") do |value|
          #deal with history of this method
          history = instance_variable_get("@#{method_name}_history")
          history ||= []
          history << value
          #setter for history of the method
          instance_variable_set("@#{method_name}_history",history)
          #setter for method
          instance_variable_set("@#{method_name}", value)
        end

        #getter for the history of a given method
        define_method("#{method_name}_history") do
          instance_variable_get("@#{method_name}_history") || []
        end
      end
    end
  end
end
end
