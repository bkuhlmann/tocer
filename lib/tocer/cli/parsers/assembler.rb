# frozen_string_literal: true

module Tocer
  module CLI
    module Parsers
      # Assembles and parses all Command Line Interface (CLI) options.
      class Assembler
        SECTIONS = [Core, Build].freeze # Order is important.

        def initialize configuration: CLI::Configuration::Loader.call,
                       sections: SECTIONS,
                       client: CLIENT
          @options = configuration.to_h
          @sections = sections
          @client = client
        end

        def call arguments = []
          sections.each { |parser| parser.call client:, options: }
          client.parse! arguments
          options
        end

        def to_h = options

        def to_s = client.to_s

        private

        attr_reader :options, :sections, :client
      end
    end
  end
end
