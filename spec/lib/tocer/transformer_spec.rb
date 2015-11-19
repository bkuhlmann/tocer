require "spec_helper"

describe Tocer::Transformer do
  let(:text) { "# Example" }
  subject { described_class.new text }

  describe "#pounds" do
    context "with a single pound sign" do
      let(:text) { "# Example" }

      it "answers a single pound sign" do
        expect(subject.pounds).to eq("#")
      end
    end

    context "with multiple pound signs" do
      let(:text) { "### Example" }

      it "answers multiple pound signs" do
        expect(subject.pounds).to eq("###")
      end
    end

    context "with no pound signs" do
      let(:text) { "" }

      it "answers an empty string" do
        expect(subject.pounds).to eq("")
      end
    end
  end

  describe "#label" do
    context "with content" do
      let(:text) { "# Example" }

      it "answers label" do
        expect(subject.label).to eq("Example")
      end
    end

    context "with new line" do
      let(:text) { "# Example\n" }

      it "answers label without new line" do
        expect(subject.label).to eq("Example")
      end
    end

    context "without content" do
      let(:text) { "" }

      it "answers an empty string" do
        expect(subject.label).to eq("")
      end
    end
  end

  describe "#bullet" do
    context "with a single pound sign" do
      let(:text) { "#" }

      it "answers single bullet" do
        expect(subject.bullet).to eq("- ")
      end
    end

    context "with multiple pound signs" do
      let(:text) { "##" }

      it "answers indented bullet" do
        expect(subject.bullet).to eq("  - ")
      end
    end

    context "with no pound signs" do
      let(:text) { "" }

      it "answers empty string" do
        expect(subject.bullet).to eq("")
      end
    end
  end

  describe "#url" do
    context "with spaces" do
      let(:text) { "# Example Space" }

      it "converts spaces to dashes" do
        expect(subject.url).to eq("example-space")
      end
    end

    context "with dashes (-)" do
      let(:text) { "# Example-" }

      it "allows dashes" do
        expect(subject.url).to eq("example-")
      end
    end

    context "with underscores (_)" do
      let(:text) { "# Example_" }

      it "allows underscores" do
        expect(subject.url).to eq("example_")
      end
    end

    context "with dots (.)" do
      let(:text) { "# 1.2" }

      it "removes dots" do
        expect(subject.url).to eq("12")
      end
    end

    context "with ampersands (&)" do
      let(:text) { "# Ex&mple" }

      it "removes ampersands" do
        expect(subject.url).to eq("exmple")
      end
    end

    context "with pluses (+)" do
      let(:text) { "# Example+" }

      it "removes pluses" do
        expect(subject.url).to eq("example")
      end
    end
  end

  describe "#transform" do
    context "without indentation" do
      let(:text) { "# Example" }

      it "answers non-indented bullet link" do
        expect(subject.transform).to eq("- [Example](#example)")
      end
    end

    context "with indentation" do
      let(:text) { "## Example" }

      it "answers indented bullet link" do
        expect(subject.transform).to eq("  - [Example](#example)")
      end
    end

    context "with multi-level indentation" do
      let(:text) { "###### Example" }

      it "answers multi-indented, bullet link" do
        expect(subject.transform).to eq("          - [Example](#example)")
      end
    end
  end
end
