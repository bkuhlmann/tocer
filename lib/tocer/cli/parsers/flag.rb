# frozen_string_literal: true

require "core"
require "refinements/structs"

module Tocer
  module CLI
    module Parsers
      # Handles parsing of Command Line Interface (CLI) flags.
      class Flag
        using Refinements::Structs

        def self.call(...) = new(...).call

        def initialize configuration = Container[:configuration], client: Parser::CLIENT
          @configuration = configuration
          @client = client
        end

        def call arguments = ::Core::EMPTY_ARRAY
          client.separator "\nOPTIONS:\n"
          private_methods.sort.grep(/add_/).each { |method| __send__ method }
          client.parse arguments
          configuration
        end

        private

        attr_reader :configuration, :client

        def add_label
          client.on(
            "--label [LABEL]",
            %(Add label. Default: "#{configuration.label}".)
          ) do |value|
            configuration.merge! label: value if value
          end
        end

        def add_include
          client.on(
            "--includes [a,b,c]",
            Array,
            %(Add include patterns. Default: #{configuration.includes}.)
          ) do |items|
            configuration.merge! includes: items if items
          end
        end
      end
    end
  end
end
