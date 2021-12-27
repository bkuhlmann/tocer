# frozen_string_literal: true

module Tocer
  module Configuration
    # Defines the content of the configuration for use throughout the gem.
    Content = Struct.new :label, :includes, keyword_init: true
  end
end
