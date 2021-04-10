# frozen_string_literal: true

require "runcom"

module Tocer
  module CLI
    module Parsers
      SECTIONS = [Core, Build].freeze # Order is important.

      # Assembles and parses all Command Line Interface (CLI) options.
      class Assembler
        def initialize configuration: CLI::Configuration::Loader.call,
                       sections: SECTIONS,
                       client: CLIENT
          @options = configuration.to_h
          @sections = sections
          @client = client
        end

        def call arguments = []
          sections.each { |parser| parser.call client: client, options: options }
          client.parse! arguments
          options
        end

        def to_h = options

        def to_s = client.to_s

        private

        attr_reader :options, :client, :sections
      end
    end
  end
end
