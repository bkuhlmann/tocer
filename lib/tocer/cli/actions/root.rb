# frozen_string_literal: true

require "sod"

module Tocer
  module CLI
    module Actions
      # Stores table of contents root path.
      class Root < Sod::Action
        include Import[:input]

        description "Set root directory."

        on %w[-r --root], argument: "[PATH]"

        default { Container[:configuration].root_dir }

        def call(path = nil) = input.root_dir = Pathname(path || default)
      end
    end
  end
end
