# frozen_string_literal: true

require "dry/container/stub"
require "infusible/stub"

RSpec.shared_context "with application dependencies" do
  using Infusible::Stub

  include_context "with temporary directory"

  let :configuration do
    Etcher.new(Tocer::Container[:defaults]).call(root_dir: temp_dir).bind(&:dup)
  end

  let(:input) { configuration.dup }
  let(:xdg_config) { Runcom::Config.new Tocer::Container[:defaults_path] }
  let(:kernel) { class_spy Kernel }
  let(:logger) { Cogger.new id: :tocer, io: StringIO.new }

  before { Tocer::Import.stub configuration:, input:, xdg_config:, kernel:, logger: }

  after { Tocer::Import.unstub :configuration, :input, :xdg_config, :kernel, :logger }
end
