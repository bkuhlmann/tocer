# frozen_string_literal: true

require "pathname"
require "refinements/structs"
require "runcom"
require "yaml"

module Tocer
  module Configuration
    # Represents the fully assembled Command Line Interface (CLI) configuration.
    class Loader
      using Refinements::Structs

      DEFAULTS = YAML.load_file(Pathname(__dir__).join("defaults.yml")).freeze
      CLIENT = Runcom::Config.new "tocer/configuration.yml", defaults: DEFAULTS

      def self.call = new.call

      def self.with_defaults = new(client: DEFAULTS)

      def initialize model: Model.new, client: CLIENT
        @model = model
        @client = client
      end

      def call = model.merge(**client.to_h)

      private

      attr_reader :model, :client
    end
  end
end
