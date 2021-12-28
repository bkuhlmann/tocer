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
        perform parser.call(arguments)
      rescue OptionParser::ParseError => error
        puts error.message
      end

      private

      attr_reader :parser, :actions

      def perform configuration
        case configuration
          in action_config: Symbol => action then process_config action
          in action_build: true then process_build configuration
          in action_version: true then puts Identity::VERSION_LABEL
          else usage
        end
      end

      def process_config(action) = actions.fetch(:config).call(action)

      def process_build(configuration) = actions.fetch(:build).call(configuration)

      def usage = puts(parser.to_s)
    end
  end
end
