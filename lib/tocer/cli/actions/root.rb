# frozen_string_literal: true

require "sod"

module Tocer
  module CLI
    module Actions
      # Stores table of contents root path.
      class Root < Sod::Action
        include Dependencies[:settings]

        description "Set root directory."

        on %w[-r --root], argument: "[PATH]"

        default { Container[:settings].root_dir }

        def call(path = default) = settings.root_dir = Pathname(path)
      end
    end
  end
end
