# frozen_string_literal: true

require "refinements/structs"

module Tocer
  module CLI
    module Parsers
      # Handles parsing of Command Line Interface (CLI) build options.
      class Build
        using Refinements::Structs

        def self.call(...) = new(...).call

        def initialize configuration = Configuration::Loader.call, client: Parser::CLIENT
          @configuration = configuration
          @client = client
        end

        def call arguments = []
          client.separator "\nBUILD OPTIONS:\n"
          private_methods.sort.grep(/add_/).each { |method| __send__ method }
          client.parse arguments
          configuration
        end

        private

        attr_reader :configuration, :client

        def add_label
          client.on(
            "-l",
            "--label [LABEL]",
            %(Label. Default: "#{configuration.build_label}".)
          ) do |value|
            configuration.merge! build_label: value if value
          end
        end

        def add_include
          client.on(
            "-i",
            "--includes [a,b,c]",
            Array,
            %(Include pattern list. Default: #{configuration.build_includes}.)
          ) do |items|
            configuration.merge! build_includes: items if items
          end
        end
      end
    end
  end
end
