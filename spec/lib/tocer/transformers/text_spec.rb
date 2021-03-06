# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Transformers::Text do
  subject(:text) { described_class.new markdown }

  describe "#label" do
    let(:markdown) { "# Example" }

    it "answers link label" do
      expect(text.label).to eq("Example")
    end
  end

  describe "#url" do
    context "with spaces" do
      let(:markdown) { "# Example Space" }

      it "converts spaces to dashes" do
        expect(text.url).to eq("example-space")
      end
    end

    context "with dashes (-)" do
      let(:markdown) { "# Example-" }

      it "allows dashes" do
        expect(text.url).to eq("example-")
      end
    end

    context "with underscores (_)" do
      let(:markdown) { "# Example_" }

      it "allows underscores" do
        expect(text.url).to eq("example_")
      end
    end

    context "with dots (.)" do
      let(:markdown) { "# 1.2" }

      it "removes dots" do
        expect(text.url).to eq("12")
      end
    end

    context "with ampersands (&)" do
      let(:markdown) { "# Ex&mple" }

      it "removes ampersands" do
        expect(text.url).to eq("exmple")
      end
    end

    context "with pluses (+)" do
      let(:markdown) { "# Example+" }

      it "removes pluses" do
        expect(text.url).to eq("example")
      end
    end
  end

  describe "#call" do
    context "with indentation" do
      let(:markdown) { "## Example" }

      it "answers indented bullet link" do
        expect(text.call).to eq("  - [Example](#example)")
      end
    end

    context "with multi-level indentation" do
      let(:markdown) { "###### Example" }

      it "answers multi-indented, bullet link" do
        expect(text.call).to eq("          - [Example](#example)")
      end
    end

    context "without indentation" do
      let(:markdown) { "# Example" }

      it "answers non-indented bullet link" do
        expect(text.call).to eq("- [Example](#example)")
      end
    end

    context "with URL suffix" do
      let(:markdown) { "# Example" }

      it "answers non-indented bullet link" do
        expect(text.call(url_suffix: 1)).to eq("- [Example](#example-1)")
      end
    end
  end
end
