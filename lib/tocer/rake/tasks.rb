# frozen_string_literal: true

require "rake"
require "tocer"
require "refinements/structs"

module Tocer
  module Rake
    # Provides Rake tasks for convenience.
    class Tasks
      include ::Rake::DSL
      using Refinements::Structs

      def self.setup = new.install

      def initialize configuration: Configuration::Loader.call, runner: Runner.new
        @configuration = configuration
        @runner = runner
      end

      def install
        desc "Add/Update Table of Contents (README)"
        task :toc, %i[label includes] do |_task, arguments|
          attributes = arguments.to_h.transform_keys includes: :build_includes, label: :build_label
          runner.call configuration.merge(**attributes)
        end
      end

      private

      attr_reader :configuration, :runner
    end
  end
end
