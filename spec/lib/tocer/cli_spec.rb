require "spec_helper"
require "tocer/cli"

describe Tocer::CLI do
  describe ".start" do
    let(:version) { "0.1.0" }
    let(:options) { [] }
    let(:command_line) { Array(command).concat options }
    let(:cli) { -> { described_class.start command_line } }

    shared_examples_for "a generate command" do
      let(:options) { ["test.md"] }
      let(:writer) { instance_spy Tocer::Writer }
      before { allow(Tocer::Writer).to receive(:new).with("test.md").and_return(writer) }

      it "generates new table of contents" do
        cli.call
        expect(writer).to have_received(:write)
      end

      it "prints status" do
        expect(&cli).to output("Generated table of contents: test.md.\n").to_stdout
      end
    end

    shared_examples_for "an edit command" do
      let(:file_path) { File.join ENV["HOME"], Tocer::Identity.file_name }

      it "edits resource file", :temp_dir do
        ClimateControl.modify EDITOR: %(printf "%s\n") do
          Dir.chdir(temp_dir) do
            expect(&cli).to output(/info\s+Editing\:\s#{file_path}\.\.\./).to_stdout
          end
        end
      end
    end

    shared_examples_for "a version command" do
      it "prints version" do
        expect(&cli).to output(/#{Tocer::Identity.label}\s#{Tocer::Identity.version}\n/).to_stdout
      end
    end

    shared_examples_for "a help command" do
      it "prints usage" do
        expect(&cli).to output(/#{Tocer::Identity.label}\s#{Tocer::Identity.version}\scommands:\n/).to_stdout
      end
    end

    describe "--generate" do
      let(:command) { "--generate" }
      it_behaves_like "a generate command"
    end

    describe "-g" do
      let(:command) { "-g" }
      it_behaves_like "a generate command"
    end

    describe "--edit" do
      let(:command) { "--edit" }
      it_behaves_like "an edit command"
    end

    describe "-e" do
      let(:command) { "-e" }
      it_behaves_like "an edit command"
    end

    describe "--version" do
      let(:command) { "--version" }
      it_behaves_like "a version command"
    end

    describe "-v" do
      let(:command) { "-v" }
      it_behaves_like "a version command"
    end

    describe "--help" do
      let(:command) { "--help" }
      it_behaves_like "a help command"
    end

    describe "-h" do
      let(:command) { "-h" }
      it_behaves_like "a help command"
    end

    context "with no command" do
      let(:command) { nil }
      it_behaves_like "a help command"
    end
  end
end
