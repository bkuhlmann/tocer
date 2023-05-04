# frozen_string_literal: true

require "rake"
require "refinements/structs"
require "tocer"

module Tocer
  module Rake
    # Registers Rake tasks for use.
    class Register
      include ::Rake::DSL
      using Refinements::Structs

      def self.call = new.call

      def initialize configuration = Container[:configuration], runner: Runner.new
        @configuration = configuration
        @runner = runner
      end

      def call
        desc "Update/Insert Table of Contents"
        task :toc, %i[label patterns] do |_task, arguments|
          runner.call configuration.merge(arguments.to_h)
        end
      end

      private

      attr_reader :configuration, :runner
    end
  end
end
