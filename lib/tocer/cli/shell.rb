# frozen_string_literal: true

module Tocer
  module CLI
    # The main Command Line Interface (CLI) object.
    class Shell
      include Actions::Import[:config, :insert, :specification, :logger]

      def initialize parser: Parser.new, **dependencies
        super(**dependencies)
        @parser = parser
      end

      def call arguments = []
        perform parser.call(arguments)
      rescue OptionParser::ParseError => error
        puts error.message
      end

      private

      attr_reader :parser

      def perform configuration
        case configuration
          in action_config: Symbol => action then config.call action
          in action_insert: true then insert.call configuration
          in action_version: true then logger.info { specification.labeled_version }
          else logger.any { parser.to_s }
        end
      end
    end
  end
end
