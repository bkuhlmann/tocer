# frozen_string_literal: true

module Tocer
  module CLI
    module Actions
      # Handles the insert action.
      class Insert
        include Tocer::Import[:kernel]

        def initialize(runner: Runner.new, **)
          super(**)
          @runner = runner
        end

        def call configuration
          runner.call(configuration).each { |path| kernel.puts "  #{path}" }
        end

        private

        attr_reader :runner
      end
    end
  end
end
