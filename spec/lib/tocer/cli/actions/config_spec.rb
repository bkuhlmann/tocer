# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Actions::Config do
  subject(:action) { described_class.new client: runcom_configuration, kernel: }

  include_context "with Runcom"

  let(:kernel) { class_spy Kernel }

  describe "#call" do
    it "edits configuration" do
      action.call :edit
      expect(kernel).to have_received(:system).with(/\$EDITOR\s.+configuration.yml/)
    end

    it "views configuration" do
      action.call :view
      expect(kernel).to have_received(:system).with(/cat\s.+configuration.yml/)
    end

    it "logs invalid configuration action" do
      action.call :bogus
      expect(kernel).to have_received(:puts).with(/Invalid configuration action: bogus./)
    end
  end
end
