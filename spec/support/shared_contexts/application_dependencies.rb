# frozen_string_literal: true

RSpec.shared_context "with application dependencies" do
  using Refinements::Struct

  include_context "with temporary directory"

  let(:settings) { Tocer::Container[:settings] }
  let(:kernel) { class_spy Kernel }
  let(:logger) { Cogger.new id: :tocer, io: StringIO.new }

  before do
    settings.merge! Etcher.call(Tocer::Container[:registry].remove_loader(1), root_dir: temp_dir)
    Tocer::Container.stub! kernel:, logger:
  end

  after { Tocer::Container.restore }
end
