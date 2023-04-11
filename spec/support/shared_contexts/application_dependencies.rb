# frozen_string_literal: true

require "dry/container/stub"
require "infusible/stub"

RSpec.shared_context "with application dependencies" do
  using Refinements::Structs
  using Infusible::Stub

  include_context "with temporary directory"

  let(:configuration) { Tocer::Configuration::Loader.with_defaults.call.merge root_dir: temp_dir }
  let(:kernel) { class_spy Kernel }
  let(:logger) { Cogger.new io: StringIO.new, formatter: :emoji }

  before { Tocer::Import.stub configuration:, kernel:, logger: }

  after { Tocer::Import.unstub :configuration, :kernel, :logger }
end
