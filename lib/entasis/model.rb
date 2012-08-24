module Entasis
  module Model
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations
    end

    module ClassMethods
      # Takes a list of symbolized attribute names and defines them
      def attributes(*attrs)
        class_variable_set :@@attribute_names, attrs.map(&:to_s)

        attr_accessor *attrs
      end
    end

    # Takes a hash and assigns keys and values to it's attributes members
    def initialize(*args)
      if args.first.is_a?(Hash) then set_attributes_from_hash(args.first) else super(*args) end
    end

    def attribute_names
      self.class.class_variable_get :@@attribute_names
    end

    # Returns an attributes hash
    def attributes
      attrs = {}
      attribute_names.each { |name| attrs[name] = send(name) }
      attrs
    end

    private
    # Takes each key and value from the hash and assigns it to it's attribute.
    def set_attributes_from_hash(hash)
      hash.each_pair { |key, value| self.send("#{key}=", value) }
    end
  end
end
