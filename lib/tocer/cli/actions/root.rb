# frozen_string_literal: true

require "refinements/structs"
require "sod"

module Tocer
  module CLI
    module Actions
      # Stores table of contents root path.
      class Root < Sod::Action
        include Import[:input]

        using Refinements::Structs

        description "Set root directory."

        on %w[-r --root], argument: "[PATH]"

        default { Container[:configuration].root_dir }

        def call(path = default) = input.merge! root_dir: Pathname(path)
      end
    end
  end
end
