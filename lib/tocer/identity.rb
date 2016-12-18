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
      "3.3.0"
    end

    def self.version_label
      "#{label} #{version}"
    end

    def self.file_name
      ".#{name}rc"
    end
  end
end
