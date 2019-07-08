# frozen_string_literal: true

module CoreData
  class DataModel
    class Entity
      attr_reader :name, :attributes, :relationships

      def initialize(entity)
        raise ArgumentError unless ::Nokogiri::XML::Element === entity

        @name = entity['name']
        @attributes = entity.xpath('attribute').collect { |element| Attribute.new(element) }
        @relationships = entity.xpath('relationship').collect { |element| Relationship.new(element) }
      end

      def to_s
        @name
      end
    end
  end
end
