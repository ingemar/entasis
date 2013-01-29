module Entasis
  module Model
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations
      class_attribute :attribute_names, :entasis_config, instance_writer: false

      self.attribute_names ||= []
      self.class_eval 'class UnknownAttributeError < StandardError; end'
    end

    module ClassMethods
      ##
      #
      # Takes a list of attribute names. Last argument can be an options hash.
      #
      #   ignore_undefined: true - Silently ignore any undefined attributes
      #
      def attributes(*attrs)
        self.entasis_config = if attrs.last.is_a?(Hash) then attrs.pop else {} end

        self.attribute_names += attrs.map(&:to_s).sort

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
    # Takes a hash of attribute names and values and set each attribute.
    #
    # If passwed an unkown attribute it will raise +class::UnknownAttributeError+
    #
    def attributes=(hash)
      hash.each do |name, value|
        if attribute_names.include?(name.to_s) || self.respond_to?("#{name}=")
          self.send("#{name}=", value)
        else
          if entasis_config[:ignore_undefined] != true
            raise self.class::UnknownAttributeError, "unknown attribute: #{name}"
          end
        end
      end
    end

    ##
    #
    # Returns all attributes serialized as hash
    #
    def attributes
      attribute_names.inject({}) { |h, name| h[name] = send(name); h }
    end
  end
end
