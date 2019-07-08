# frozen_string_literal: true

require 'nokogiri'

module CoreData
  class DataModel
    attr_reader :name, :version, :entities

    def initialize(data_model)
      loop do
        case data_model
        when File, /^\<\?xml/
          (data_model = ::Nokogiri::XML(data_model)) && redo
        when String
          case data_model
          when /\.xcdatamodeld?$/
            (data_model = Dir[File.join(data_model, '/**/contents')].first) && redo
          else
            (data_model = ::File.read(data_model)) && redo
          end
        when ::Nokogiri::XML::Document
          break
        else
          raise ArgumentError
        end
      end

      model = data_model.at_xpath('model')

      @name = model['name']
      @version = model['systemVersion']
      @entities = model.xpath('entity').collect { |element| Entity.new(element) }
    end
  end
end

require 'core_data/data_model/entity'
require 'core_data/data_model/attribute'
require 'core_data/data_model/relationship'
