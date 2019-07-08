# frozen_string_literal: true

module CoreData
  class DataModel
    class Attribute
      attr_reader :name, :type, :identifier, :version_hash_modifier, :default_value, :minimum_value, :maximum_value, :regular_expression

      def initialize(attribute)
        raise ArgumentError unless ::Nokogiri::XML::Element === attribute

        @name = attribute['name']
        @type = attribute['attributeType']
        @identifier = attribute['elementID']
        @version_hash_modifier = attribute['versionHashModifier']

        @default_value = default_value_from_string(attribute['defaultValueString'])
        @minimum_value = range_value_from_string(attribute['minValueString'])
        @maximum_value = range_value_from_string(attribute['maxValueString'])

        @regular_expression = begin
                                Regexp.new(attributes['regularExpressionString'])
                              rescue StandardError
                                nil
                              end

        @optional = attribute['optional'] == 'YES'
        @transient = attribute['transient'] == 'YES'
        @indexed = attribute['indexed'] == 'YES'
        @syncable = attribute['syncable'] == 'YES'
      end

      def to_s
        [@name, @type].to_s
      end

      %i[optional transient indexed syncable].each do |symbol|
        define_method("#{symbol}?") { !!instance_variable_get("@#{symbol}".intern) }
      end

      private

      def default_value_from_string(string)
        return nil unless string

        case @type
        when 'Integer 16', 'Integer 32', 'Integer 64'
          string.to_i
        when 'Float', 'Decimal'
          string.to_f
        when 'Boolean'
          string == 'YES'
        else
          string
               end
      end

      def range_value_from_string(string)
        return nil unless string

        case @type
        when 'Float', 'Decimal'
          string.to_f
        when 'Date'
          string
        else
          string.to_i
               end
      end
    end
  end
end
