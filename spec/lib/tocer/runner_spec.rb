# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Runner, :temp_dir do
  let(:path) { "." }
  let(:label) { "# Test" }
  let(:whitelist) { [] }
  let :configuration do
    {
      label: label,
      whitelist: whitelist
    }
  end
  let(:writer_class) { class_spy Tocer::Writer }
  let(:writer_instance) { instance_spy Tocer::Writer }
  let(:markdown_file) { Pathname File.join(temp_dir, "test.md") }
  let(:text_file) { Pathname File.join(temp_dir, "test.txt") }

  subject { described_class.new path, configuration: configuration, writer: writer_class }

  before do
    FileUtils.touch markdown_file
    FileUtils.touch text_file
  end

  describe "#files" do
    context "with defaults" do
      subject { described_class.new }

      it "answers empty array" do
        expect(subject.files).to be_empty
      end
    end

    context "with path only" do
      let(:path) { temp_dir }

      it "answers empty array" do
        expect(subject.files).to be_empty
      end
    end

    context "with whitelist only" do
      let(:whitelist) { ["*.md"] }

      it "answers files with matching extensions" do
        Dir.chdir temp_dir do
          expect(subject.files).to contain_exactly(Pathname("./test.md"))
        end
      end
    end

    context "with path and whitelist string" do
      let(:path) { temp_dir }
      let(:whitelist) { "*.md" }

      it "answers files with matching extensions" do
        expect(subject.files).to contain_exactly(markdown_file)
      end
    end

    context "with path and whitelist array" do
      let(:path) { temp_dir }
      let(:whitelist) { ["*.md"] }

      it "answers files with matching extensions" do
        expect(subject.files).to contain_exactly(markdown_file)
      end
    end

    context "with invalid path" do
      let(:path) { "bogus" }

      it "answers empty array" do
        expect(subject.files).to be_empty
      end
    end

    context "with path and invalid whitelist" do
      let(:path) { temp_dir }
      let(:whitelist) { ["bogus", "~#}*^"] }

      it "answers empty array" do
        expect(subject.files).to be_empty
      end
    end

    context "with path and whitelist without wildcards" do
      let(:path) { temp_dir }
      let(:whitelist) { [".md"] }

      it "answers empty array" do
        expect(subject.files).to be_empty
      end
    end

    context "with path and recursive whitelist" do
      let(:path) { temp_dir }
      let(:whitelist) { ["**/*.md"] }
      let(:nested_file) { Pathname File.join(temp_dir, "nested", "nested.md") }

      before do
        FileUtils.mkdir File.join(temp_dir, "nested")
        FileUtils.touch nested_file
      end

      it "answers empty array" do
        expect(subject.files).to contain_exactly(nested_file, markdown_file)
      end
    end
  end

  describe "#run" do
    context "without files" do
      it "doesn't update files" do
        subject.run
        expect(writer_instance).to_not have_received(:write)
      end
    end

    context "with files" do
      let(:path) { temp_dir }
      let(:whitelist) { ["*.md"] }

      before do
        allow(writer_class).to receive(:new)
          .with(markdown_file, label: label)
          .and_return(writer_instance)
      end

      it "updates files" do
        subject.run
        expect(writer_instance).to have_received(:write)
      end
    end
  end
end
