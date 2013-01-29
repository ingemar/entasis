module Entasis
  module TransposeKeys
    extend ActiveSupport::Concern

    included do
      alias_method_chain :attributes=, :transpose
    end

    ##
    #
    # Takes a hash of attribute names and values and set each attribute.
    #
    # If passwed an unkown attribute it ill raise +class::UnknownAttributeError+
    #
    def attributes_with_transpose=(hash)
      hash.each do |name, value|
        transposed_name = name.to_s.dup.underscore.downcase
        if attribute_names.include?(transposed_name) || self.respond_to?("#{transposed_name}=")
          self.send("#{transposed_name}=", value)
        else
          if entasis_config[:ignore_undefined] != true
            raise self.class::UnknownAttributeError, "unknown attribute: #{transposed_name} (transposed from #{name})"
          end
        end
      end
    end
  end
end
