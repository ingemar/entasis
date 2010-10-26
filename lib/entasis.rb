module Entasis
  module Base
    module ClassMethods; end

    module InstanceMethods
      # Takes a hash and assigns keys and values to it's Struct members
      def initialize(*args)
        if args.first.is_a?(Hash) then set_attributes_from_hash(args.first) else super(*args) end
      end

      # Returns an attributes hash
      def attributes
        attrs = {}
        attribute_names.each { |name| attrs[name] = send(name) }
        attrs
      end

      private
      # Takes each key and value from the hash and assigns it to it's Struck member
      # after checking that there is no setter method defined.
      # If a setter method is defined it will take precedence.
      def set_attributes_from_hash(hash)
        hash.each_pair do |key, value|
          if self.attribute_names.include?(key.to_s)
            if self.respond_to?("#{key}=") then self.send("#{key}=", value) else self[key] = value end
          end
        end
      end
    end

    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.send(:include, InstanceMethods)

      # Behave a bit more like Rails
      receiver.send(:alias_method, *[:attribute_names, :members])
    end
  end
end

