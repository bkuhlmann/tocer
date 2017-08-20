# frozen_string_literal: true

module Tocer
  # Gem identity information.
  module Identity
    def self.name
      "tocer"
    end

    def self.label
      "Tocer"
    end

    def self.version
      "6.2.0"
    end

    def self.version_label
      "#{label} #{version}"
    end
  end
end
