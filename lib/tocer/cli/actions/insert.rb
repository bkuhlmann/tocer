# frozen_string_literal: true

module Tocer
  module CLI
    module Actions
      # Handles the insert action.
      class Insert
        def initialize runner: Runner.new, container: Container
          @runner = runner
          @container = container
        end

        def call configuration
          runner.call(configuration) { |path| logger.info { "  #{path}" } }
        end

        private

        attr_reader :runner, :container

        def logger = container[__method__]
      end
    end
  end
end
