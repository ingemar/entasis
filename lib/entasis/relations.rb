module Entasis
  module Relations
    extend ActiveSupport::Concern

    module ClassMethods
      ##
      #
      # Takes a list of relations. Speciefy each relation as a
      # pluralization of corresponding class.
      #
      # Last argument can be an options hash:
      #
      #   class: provide a custom class name
      #
      # This macro will give each instance corresponding
      # setter and getter methods. Passing a collection of
      # corresponding instances of the given class will populate
      # the collection. Passing hashes will try to instanciate
      # new objects of the relation's class.
      #
      # To set the inverse association and tie the objects together
      # specify the +belongs_to+ relation in the other class.
      #
      def has_many(*relations)
        options = relations.last.is_a?(Hash) ? relations.pop : {}

        relations.each do |relation|
          relation_model = options[:class] || relation.to_s.singularize.camelize

          self.class_eval <<-RUBY
            def #{relation}=(resources)
              @#{relation} = []

              resources.each do |resource|
                unless resource.is_a? #{relation_model}
                  resource = #{relation_model}.new resource
                end

                if inverse_relation = resource.belongings[self.class.to_s]
                  resource.send "\#{inverse_relation}=", self
                end

                @#{relation} << resource
              end
            end

            def #{relation}
              @#{relation} || []
            end
          RUBY
        end
      end

      #
      # To complete the inverse relationship and tie two models togeter
      # specify the +belongs_to+ relationship.
      #
      # Last argument can be an options hash:
      #
      #   class: provide a custom class name
      #
      def belongs_to(*relations)
        options = relations.last.is_a?(Hash) ? relations.pop : {}

        relations.each do |relation|
          relation_model = options[:class] || relation.to_s.singularize.camelize

          self.belongings[relation_model] = relation
        end

        attr_accessor *relations
      end
    end
  end
end
