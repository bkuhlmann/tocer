# frozen_string_literal: true

module Tocer
  module CLI
    module Processors
      # Handles the Command Line Interface (CLI) for building of table of contents.
      class Build
        def initialize runner: Runner.new
          @runner = runner
        end

        def call root_dir = ".", configuration = {}
          runner.call(root_dir:, **configuration.slice(:label, :includes)) do |path|
            puts "  #{path}"
          end
        end

        private

        attr_reader :runner
      end
    end
  end
end
