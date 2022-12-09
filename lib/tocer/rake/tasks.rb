# frozen_string_literal: true

require "rake"
require "refinements/structs"
require "tocer"

module Tocer
  module Rake
    # Provides Rake tasks for convenience.
    class Tasks
      include ::Rake::DSL
      using Refinements::Structs

      def self.setup = new.install

      def initialize configuration = Container[:configuration], runner: Runner.new
        @configuration = configuration
        @runner = runner
      end

      def install
        desc "Add/Update Table of Contents (README)"
        task :toc, %i[label includes] do |_task, arguments|
          runner.call configuration.merge(**arguments.to_h)
        end
      end

      private

      attr_reader :configuration, :runner
    end
  end
end
