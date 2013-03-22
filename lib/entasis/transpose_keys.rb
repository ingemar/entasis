module Entasis
  module TransposeKeys
    extend ActiveSupport::Concern

    included do
      alias_method_chain :attributes=, :transpose
    end

    ##
    #
    # Takes a hash of attribute names and values and set each attribute.
    # Before trying to set the given attribute it transpose the name of that
    # attribute from camelcased to underscored.
    #
    # If strict attribute name checking is enabled it will raise
    # an +UnknownAttributeError+ for that class.
    #
    def attributes_with_transpose=(hash)
      hash.each do |name, value|
        transposed_name = name.to_s.dup.underscore.downcase
        if attribute_names.include?(transposed_name) || self.respond_to?("#{transposed_name}=")
          self.send("#{transposed_name}=", value)
        else
          if attributes_config[:strict] == true
            raise self.class::UnknownAttributeError, "unknown attribute: #{transposed_name} (transposed from #{name})"
          end
        end
      end
    end
  end
end
