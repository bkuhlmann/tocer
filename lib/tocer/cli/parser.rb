# frozen_string_literal: true

require "optparse"

module Tocer
  module CLI
    # Assembles and parses all Command Line Interface (CLI) options.
    class Parser
      CLIENT = OptionParser.new nil, 40, "  "
      SECTIONS = [Parsers::Core, Parsers::Build].freeze # Order is important.

      def initialize configuration = Configuration::Loader.call, sections: SECTIONS, client: CLIENT
        @configuration = configuration.dup
        @sections = sections
        @client = client
      end

      def call arguments = []
        sections.each { |parser| parser.call configuration, client: }
        client.parse arguments
        configuration.freeze
      end

      def to_s = client.to_s

      private

      attr_reader :configuration, :sections, :client
    end
  end
end
