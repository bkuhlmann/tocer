# frozen_string_literal: true

module Tocer
  module CLI
    # The main Command Line Interface (CLI) object.
    class Shell
      PROCESSORS = {config: Processors::Config.new, build: Processors::Build.new}.freeze

      def initialize parser: Parsers::Assembler.new, processors: PROCESSORS
        @parser = parser
        @processors = processors
      end

      def call arguments = []
        parse arguments

        case options
          in config: action then process_config action
          in build: path then process_build path
          in version: then puts version
          in help: then usage
          else usage
        end
      end

      private

      attr_reader :parser, :processors

      def parse arguments = []
        parser.call arguments
      rescue StandardError => error
        puts error.message
      end

      def process_config(action) = processors.fetch(:config).call(action)

      def process_build(path) = processors.fetch(:build).call(path, options)

      def options = parser.to_h

      def usage = puts(parser.to_s)
    end
  end
end
