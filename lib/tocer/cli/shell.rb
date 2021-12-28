# frozen_string_literal: true

module Tocer
  module CLI
    # The main Command Line Interface (CLI) object.
    class Shell
      ACTIONS = {config: Actions::Config.new, build: Actions::Build.new}.freeze

      def initialize parser: Parser.new, actions: ACTIONS
        @parser = parser
        @actions = actions
      end

      def call arguments = []
        parse arguments

        case options
          in config: action then process_config action
          in build: path then process_build path
          in version: then puts version
          else usage
        end
      end

      private

      attr_reader :parser, :actions

      def parse arguments = []
        parser.call arguments
      rescue StandardError => error
        puts error.message
      end

      def process_config(action) = actions.fetch(:config).call(action)

      def process_build(path) = actions.fetch(:build).call(path, options)

      def options = parser.to_h

      def usage = puts(parser.to_s)
    end
  end
end
