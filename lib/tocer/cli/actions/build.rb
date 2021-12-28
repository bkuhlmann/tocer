# frozen_string_literal: true

module Tocer
  module CLI
    module Actions
      # Handles the build action.
      class Build
        def initialize runner: Runner.new
          @runner = runner
        end

        def call(configuration) = runner.call(configuration) { |path| puts "  #{path}" }

        private

        attr_reader :runner
      end
    end
  end
end
