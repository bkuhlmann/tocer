# frozen_string_literal: true

require "rake"
require "refinements/struct"
require "tocer"

module Tocer
  module Rake
    # Registers Rake tasks for use.
    class Register
      include ::Rake::DSL
      include Dependencies[:settings]

      using Refinements::Struct

      def self.call = new.call

      def initialize(runner: Runner.new, **)
        @runner = runner
        super(**)
      end

      def call
        desc "Update/Insert Table of Contents"
        task :toc, %i[label patterns] do |_task, arguments|
          settings.with! arguments
          runner.call
        end
      end

      private

      attr_reader :runner
    end
  end
end
