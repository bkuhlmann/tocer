# frozen_string_literal: true

RSpec.shared_context "with application configuration" do
  using Refinements::Structs

  include_context "with temporary directory"

  let(:configuration) { Tocer::Configuration::Loader.with_defaults.call.merge build_path: temp_dir }
end
