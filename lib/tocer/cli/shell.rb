# frozen_string_literal: true

require "core"

module Tocer
  module CLI
    # The main Command Line Interface (CLI) object.
    class Shell
      include Actions::Import[:config, :insert, :kernel, :logger, :specification]

      def initialize(parser: Parser.new, **)
        super(**)
        @parser = parser
      end

      def call arguments = Core::EMPTY_ARRAY
        act_on parser.call(arguments)
      rescue OptionParser::ParseError => error
        logger.error { error.message }
      end

      private

      attr_reader :parser

      def act_on configuration
        case configuration
          in action_config: Symbol => action then config.call action
          in action_insert: true then insert.call configuration
          in action_version: true then kernel.puts specification.labeled_version
          else kernel.puts parser.to_s
        end
      end
    end
  end
end
