# frozen_string_literal: true

require "pathname"
require "refinements/structs"
require "sod"

module Tocer
  module CLI
    module Commands
      # Stores table of contents root path.
      class Upsert < Sod::Command
        include Import[:inputs, :kernel]

        handle "upsert"

        description "Update/insert table of contents."

        on Actions::Root
        on Actions::Label
        on Actions::Pattern

        def initialize(runner: Runner.new, **)
          super(**)
          @runner = runner
        end

        def call = runner.call inputs

        private

        attr_reader :runner
      end
    end
  end
end
