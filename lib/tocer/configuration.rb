module Tocer
  # Default configuration for gem with support for custom settings.
  class Configuration
    attr_reader :file_path
    attr_writer :label

    def initialize file_path: File.join(ENV["HOME"], Identity.file_name)
      @file_path = file_path
      @settings = load_settings
    end

    def label
      @label ||= settings.fetch(:label, "# Table of Contents")
    end

    private

    attr_reader :settings

    def load_settings
      return {} unless File.exist?(file_path)
      yaml = YAML.load_file file_path
      yaml.is_a?(Hash) ? yaml : {}
    end
  end
end
