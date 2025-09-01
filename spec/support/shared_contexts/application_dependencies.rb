# frozen_string_literal: true

RSpec.shared_context "with application dependencies" do
  using Refinements::Struct

  include_context "with temporary directory"

  let(:settings) { Tocer::Container[:settings] }
  let(:logger) { Cogger.new id: :tocer, io: StringIO.new }
  let(:io) { StringIO.new }

  before do
    settings.with! Etcher.call(Tocer::Container[:registry].remove_loader(1), root_dir: temp_dir)
    Tocer::Container.stub! logger:, io:
  end

  after { Tocer::Container.restore }
end
