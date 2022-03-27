# frozen_string_literal: true

require "dry/container/stub"
require "auto_injector/stub"

RSpec.shared_context "with application dependencies" do
  using Refinements::Structs
  using AutoInjector::Stub

  include_context "with temporary directory"

  let(:configuration) { Tocer::Configuration::Loader.with_defaults.call.merge root_dir: temp_dir }
  let(:kernel) { class_spy Kernel }

  let :logger do
    Cogger::Client.new Logger.new(StringIO.new),
                       formatter: ->(_severity, _name, _at, message) { "#{message}\n" }
  end

  before { Tocer::Import.stub configuration:, kernel:, logger: }

  after { Tocer::Import.unstub :configuration, :kernel, :logger }
end
