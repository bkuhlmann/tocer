# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Transformers::Link do
  subject(:link) { described_class.new markdown }

  describe "#label" do
    context "with an embedded link" do
      let(:markdown) { "# [Example](https://www.example.com)" }

      it "answers link label" do
        expect(link.label).to eq("Example")
      end
    end

    context "with an embedded link wrapped in text" do
      let(:markdown) { "# Section 1 [Example](https://www.example.com): Introduction" }

      it "answers link label" do
        expect(link.label).to eq("Section 1 Example: Introduction")
      end
    end

    context "with a link that uses parenthesis" do
      let(:markdown) { "# Section 1 [Example](https://www.example_(see_more).com)" }

      it "answers link label" do
        expect(link.label).to eq("Section 1 Example")
      end
    end
  end

  describe "#url" do
    context "with spaces" do
      let(:markdown) { "# [Example Space](https://www.example.com)" }

      it "converts spaces to dashes" do
        expect(link.url).to eq("example-space")
      end
    end

    context "with dashes (-)" do
      let(:markdown) { "# [Example-](https://www.example.com)" }

      it "allows dashes" do
        expect(link.url).to eq("example-")
      end
    end

    context "with underscores (_)" do
      let(:markdown) { "# [Example_](https://www.example.com)" }

      it "allows underscores" do
        expect(link.url).to eq("example_")
      end
    end

    context "with dots (.)" do
      let(:markdown) { "# [Example 1.2](https://www.example.com)" }

      it "removes dots" do
        expect(link.url).to eq("example-12")
      end
    end

    context "with ampersands (&)" do
      let(:markdown) { "# [Ex&mple](https://www.example.com)" }

      it "removes ampersands" do
        expect(link.url).to eq("exmple")
      end
    end

    context "with pluses (+)" do
      let(:markdown) { "# [Example+](https://www.example.com)" }

      it "removes pluses" do
        expect(link.url).to eq("example")
      end
    end
  end

  describe "#call" do
    context "with indentation" do
      let(:markdown) { "## [Example](https://www.example.com)" }

      it "answers indented bullet link" do
        expect(link.call).to eq("  - [Example](#example)")
      end
    end

    context "with multi-level indentation" do
      let(:markdown) { "###### [Example](https://www.example.com)" }

      it "answers multi-indented, bullet link" do
        expect(link.call).to eq("          - [Example](#example)")
      end
    end

    context "without indentation" do
      let(:markdown) { "# [Example](https://www.example.com)" }

      it "answers non-indented bullet link" do
        expect(link.call).to eq("- [Example](#example)")
      end
    end

    context "with URL suffix" do
      let(:markdown) { "# [Example](https://www.example.com)" }

      it "answers non-indented bullet link" do
        expect(link.call(url_suffix: 1)).to eq("- [Example](#example-1)")
      end
    end
  end
end
