module Entasis
  module Model
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations

      self.class_eval 'class UnknownAttributeError < StandardError; end'
    end

    module ClassMethods
      # Takes a list of symbolized attribute names and defines them
      def attributes(*attrs)
        class_variable_set :@@attribute_names, attrs.map(&:to_s)

        attr_accessor *attrs
      end
    end

    # Takes a hash and assigns keys and values to it's attributes members
    def initialize(hash)
      self.attributes = hash
    end

    def attribute_names
      self.class.class_variable_get :@@attribute_names
    end

    def attributes=(hash)
      hash.each do |name, value|
        if attribute_names.include?(name.to_s) || self.respond_to?("#{name}=")
          self.send("#{name}=", value)
        else
          raise self.class::UnknownAttributeError, "unkown attribute \"#{name}\""
        end
      end
    end

    # Returns an attributes hash
    def attributes
      attrs = {}
      attribute_names.each { |name| attrs[name] = send(name) }
      attrs
    end
  end
end
