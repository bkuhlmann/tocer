# frozen_string_literal: true

module Tocer
  module CLI
    # The main Command Line Interface (CLI) object.
    class Shell
      ACTIONS = {config: Actions::Config.new, insert: Actions::Insert.new}.freeze

      def initialize parser: Parser.new, actions: ACTIONS, container: Container
        @parser = parser
        @actions = actions
        @container = container
      end

      def call arguments = []
        perform parser.call(arguments)
      rescue OptionParser::ParseError => error
        puts error.message
      end

      private

      attr_reader :parser, :actions, :container

      def perform configuration
        case configuration
          in action_config: Symbol => action then process_config action
          in action_insert: true then process_insert configuration
          in action_version: true then logger.info { specification.labeled_version }
          else logger.any { parser.to_s }
        end
      end

      def process_config(action) = actions.fetch(:config).call(action)

      def process_insert(configuration) = actions.fetch(:insert).call(configuration)

      def usage = puts(parser.to_s)

      def specification = container[__method__]

      def logger = container[__method__]
    end
  end
end
