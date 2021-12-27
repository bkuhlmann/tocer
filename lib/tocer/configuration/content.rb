# frozen_string_literal: true

module Tocer
  module Configuration
    # Defines the content of the configuration for use throughout the gem.
    Content = Struct.new(
      :action_build,
      :action_config,
      :action_help,
      :action_version,
      :build_includes,
      :build_label,
      :build_path,
      keyword_init: true
    ) do
      def initialize *arguments
        super
        freeze
      end
    end
  end
end
