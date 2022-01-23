# frozen_string_literal: true

require "dry/container/stub"

RSpec.shared_context "with application container" do
  using Refinements::Structs

  include_context "with temporary directory"

  let(:container) { Tocer::Container }

  let(:configuration) { Tocer::Configuration::Loader.with_defaults.call.merge root_dir: temp_dir }
  let(:kernel) { class_spy Kernel }

  before do
    container.enable_stubs!
    container.stub :configuration, configuration
    container.stub :kernel, kernel
  end

  after do
    container.unstub :configuration
    container.unstub :kernel
  end
end
