module Entasis
  module Model
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations
      class_attribute :attribute_names
      self.attribute_names ||= []
      self.class_eval 'class UnknownAttributeError < StandardError; end'
    end

    module ClassMethods
      ##
      #
      # Takes a list of attribute names
      #
      def attributes(*attrs)
        self.attribute_names += attrs.map(&:to_s)

        attr_accessor *attrs
      end
    end

    ##
    #
    # Takes a hash and assigns keys and values to it's attributes members
    #
    def initialize(hash={})
      self.attributes = hash
    end

    ##
    #
    # Returns a list of attribute names
    #
    def attribute_names
      self.class.class_variable_get :@@attribute_names
    end

    ##
    #
    # Takes a hash of attribute names and values and set each attribute.
    #
    # If passwed an unkown attribute it ill raise +class::UnknownAttributeError+
    #
    def attributes=(hash)
      hash.each do |name, value|
        if attribute_names.include?(name.to_s) || self.respond_to?("#{name}=")
          self.send("#{name}=", value)
        else
          raise self.class::UnknownAttributeError, "unkown attribute: #{name}"
        end
      end
    end

    ##
    #
    # Returns all attributes serialied as hash
    #
    def attributes
      attribute_names.inject({}) { |h, name| h[name] = send(name); h }
    end
  end
end
