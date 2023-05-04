# frozen_string_literal: true

require "dry/container/stub"
require "infusible/stub"

RSpec.shared_context "with application dependencies" do
  using Infusible::Stub

  include_context "with temporary directory"

  let :configuration do
    Etcher.new(Tocer::Container[:defaults]).call(root_dir: temp_dir).bind(&:dup)
  end

  let(:xdg_config) { Runcom::Config.new Tocer::Container[:defaults_path] }
  let(:kernel) { class_spy Kernel }
  let(:logger) { Cogger.new io: StringIO.new, formatter: :emoji }

  before { Tocer::Import.stub configuration:, xdg_config:, kernel:, logger: }

  after { Tocer::Import.unstub :configuration, :xdg_config, :kernel, :logger }
end
