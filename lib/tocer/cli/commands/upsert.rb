# frozen_string_literal: true

require "sod"

module Tocer
  module CLI
    module Commands
      # Stores table of contents root path.
      class Upsert < Sod::Command
        handle "upsert"

        description "Update/insert table of contents."

        on Actions::Root
        on Actions::Label
        on Actions::Pattern

        def initialize(runner: Runner.new, **)
          @runner = runner
          super(**)
        end

        def call = runner.call

        private

        attr_reader :runner
      end
    end
  end
end
