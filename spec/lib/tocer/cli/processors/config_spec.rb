# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Processors::Config, :runcom do
  subject(:processor) { described_class.new configuration: runcom_configuration, kernel: kernel }

  let(:kernel) { class_spy Kernel }

  describe "#call" do
    it "edits configuration" do
      processor.call :edit
      expect(kernel).to have_received(:system).with(/\$EDITOR\s.+configuration.yml/)
    end

    it "views configuration" do
      processor.call :view
      expect(kernel).to have_received(:system).with(/cat\s.+configuration.yml/)
    end

    it "fails with invalid configuration" do
      expectation = proc { processor.call :bogus }
      expect(&expectation).to raise_error(StandardError, /Invalid configuration action: bogus./)
    end
  end
end
