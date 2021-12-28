# frozen_string_literal: true

require "optparse"

module Tocer
  module CLI
    # Assembles and parses all Command Line Interface (CLI) options.
    class Parser
      CLIENT = OptionParser.new nil, 40, "  "
      SECTIONS = [Parsers::Core, Parsers::Build].freeze # Order is important.

      def initialize configuration: Configuration::Loader.call, sections: SECTIONS, client: CLIENT
        @options = configuration.to_h
        @sections = sections
        @client = client
      end

      def call arguments = []
        sections.each { |parser| parser.call client:, options: }
        client.parse arguments
        options
      end

      def to_h = options

      def to_s = client.to_s

      private

      attr_reader :options, :sections, :client
    end
  end
end
