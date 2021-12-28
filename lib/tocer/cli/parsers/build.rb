# frozen_string_literal: true

module Tocer
  module CLI
    module Parsers
      # Handles parsing of Command Line Interface (CLI) build options.
      class Build
        def self.call(...) = new(...).call

        def initialize options: {}, configuration: Configuration::Loader.call, client: Parser::CLIENT
          @options = options
          @configuration = configuration
          @client = client
        end

        def call arguments = []
          client.separator "\nBUILD OPTIONS:\n"
          private_methods.sort.grep(/add_/).each { |method| __send__ method }
          arguments.empty? ? arguments : client.parse(arguments)
        end

        private

        attr_reader :options, :configuration, :client

        def add_label
          client.on(
            "-l",
            "--label [LABEL]",
            %(Label. Default: "#{Configuration::Loader.call.label}".)
          ) do |value|
            options[:label] = value || configuration.to_h.fetch(:label)
          end
        end

        def add_include
          client.on(
            "-i",
            "--includes [a,b,c]",
            Array,
            %(Include pattern list. Default: #{Configuration::Loader.call.includes}.)
          ) do |value|
            list = Array value
            options[:includes] = list.empty? ? configuration.to_h.fetch(:includes) : list
          end
        end
      end
    end
  end
end
