# frozen_string_literal: true

require "rake"
require "tocer"

module Tocer
  module Rake
    class Tasks
      include ::Rake::DSL

      def self.setup
        new.install
      end

      def initialize configuration: Tocer::Configuration.default, runner: Runner
        @configuration = configuration
        @runner = runner
      end

      def install
        desc "Add/Update Table of Contents (README)"
        task :toc, %i[label includes] do |_task, arguments|
          inputs = {label: arguments[:label], includes: arguments[:includes]}.compact
          updated_configuration = configuration.merge inputs
          runner.new(configuration: updated_configuration.to_h).call
        end
      end

      private

      attr_reader :configuration, :runner
    end
  end
end
