# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Runner, :temp_dir do
  subject(:runner) { described_class.new path, configuration: configuration, writer: writer_class }

  let(:path) { "." }
  let(:label) { "# Test" }
  let(:includes) { [] }
  let :configuration do
    {
      label: label,
      includes: includes
    }
  end
  let(:writer_class) { class_spy Tocer::Writer }
  let(:writer_instance) { instance_spy Tocer::Writer }
  let(:markdown_file) { Pathname File.join(temp_dir, "test.md") }
  let(:text_file) { Pathname File.join(temp_dir, "test.txt") }

  before do
    FileUtils.touch markdown_file
    FileUtils.touch text_file
  end

  describe "#files" do
    context "with defaults" do
      subject(:runner) { described_class.new }

      it "answers empty array" do
        expect(runner.files).to be_empty
      end
    end

    context "with path only" do
      let(:path) { temp_dir }

      it "answers empty array" do
        expect(runner.files).to be_empty
      end
    end

    context "with include list only" do
      let(:includes) { ["*.md"] }

      it "answers files with matching extensions" do
        Dir.chdir temp_dir do
          expect(runner.files).to contain_exactly(Pathname("./test.md"))
        end
      end
    end

    context "with path and include list string" do
      let(:path) { temp_dir }
      let(:includes) { "*.md" }

      it "answers files with matching extensions" do
        expect(runner.files).to contain_exactly(markdown_file)
      end
    end

    context "with path and include list array" do
      let(:path) { temp_dir }
      let(:includes) { ["*.md"] }

      it "answers files with matching extensions" do
        expect(runner.files).to contain_exactly(markdown_file)
      end
    end

    context "with invalid path" do
      let(:path) { "bogus" }

      it "answers empty array" do
        expect(runner.files).to be_empty
      end
    end

    context "with path and invalid include list" do
      let(:path) { temp_dir }
      let(:includes) { ["bogus", "~#}*^"] }

      it "answers empty array" do
        expect(runner.files).to be_empty
      end
    end

    context "with path and include list without wildcards" do
      let(:path) { temp_dir }
      let(:includes) { [".md"] }

      it "answers empty array" do
        expect(runner.files).to be_empty
      end
    end

    context "with path and recursive include list" do
      let(:path) { temp_dir }
      let(:includes) { ["**/*.md"] }
      let(:nested_file) { Pathname File.join(temp_dir, "nested", "nested.md") }

      before do
        FileUtils.mkdir File.join(temp_dir, "nested")
        FileUtils.touch nested_file
      end

      it "answers recursed files" do
        expect(runner.files).to contain_exactly(nested_file, markdown_file)
      end
    end
  end

  describe "#call" do
    context "without files" do
      it "doesn't update files" do
        runner.call
        expect(writer_instance).not_to have_received(:call)
      end
    end

    context "with files" do
      let(:path) { temp_dir }
      let(:includes) { ["*.md"] }

      before do
        allow(writer_class).to receive(:new)
          .with(markdown_file, label: label)
          .and_return(writer_instance)
      end

      it "updates files" do
        runner.call
        expect(writer_instance).to have_received(:call)
      end
    end
  end
end
