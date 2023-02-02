# frozen_string_literal: true

module Tocer
  module CLI
    module Actions
      # Handles the insert action.
      class Insert
        include Tocer::Import[:logger]

        def initialize(runner: Runner.new, **)
          super(**)
          @runner = runner
        end

        def call configuration
          runner.call(configuration) { |path| logger.info { "  #{path}" } }
        end

        private

        attr_reader :runner
      end
    end
  end
end
