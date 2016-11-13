# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI do
  describe ".start" do
    let(:version) { "0.1.0" }
    let(:options) { [] }
    let(:command_line) { Array(command).concat options }
    let :cli do
      lambda do
        load "tocer/cli.rb" # Ensures clean Thor `.method_option` evaluation per spec.
        described_class.start command_line
      end
    end

    shared_examples_for "a generate command" do
      let(:writer) { instance_spy Tocer::Writer }

      context "without default label", :temp_dir do
        let(:label) { "# Table of Contents" }
        let(:options) { ["test.md"] }
        before { allow(Tocer::Writer).to receive(:new).with("test.md", label: label).and_return(writer) }

        it "generates new table of contents" do
          ClimateControl.modify HOME: temp_dir do
            cli.call
            expect(writer).to have_received(:write)
          end
        end

        it "prints status" do
          ClimateControl.modify HOME: temp_dir do
            expect(&cli).to output("Generated table of contents: test.md.\n").to_stdout
          end
        end
      end

      context "with custom label", :temp_dir do
        let(:label) { "# Index" }
        let(:options) { ["test.md", "--label", label] }
        before { allow(Tocer::Writer).to receive(:new).with("test.md", label: label).and_return(writer) }

        it "generates new table of contents" do
          ClimateControl.modify HOME: temp_dir do
            cli.call
            expect(writer).to have_received(:write)
          end
        end

        it "prints status" do
          ClimateControl.modify HOME: temp_dir do
            expect(&cli).to output("Generated table of contents: test.md.\n").to_stdout
          end
        end
      end

      context "with configured label", :temp_dir do
        let(:label) { "# Index" }
        let(:options) { ["test.md"] }
        let(:configuration_path) { File.join temp_dir, Tocer::Identity.file_name }
        before do
          File.open(configuration_path, "w") { |file| file.write %(:label: "#{label}") }
        end

        it "uses local label" do
          ClimateControl.modify HOME: temp_dir do
            Dir.chdir(temp_dir) do
              allow(Tocer::Writer).to receive(:new).with("test.md", label: label).and_return(writer)
              cli.call
            end
          end
        end
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

    shared_examples_for "a config command", :temp_dir do
      let(:configuration_path) { File.join temp_dir, Tocer::Identity.file_name }
      before { FileUtils.touch configuration_path }

      context "with info option" do
        let(:options) { %w[-i] }

        it "prints configuration path" do
          Dir.chdir(temp_dir) do
            expect(&cli).to output("#{configuration_path}\n").to_stdout
          end
        end
      end

      context "with no options" do
        it "prints help text" do
          expect(&cli).to output(/Manage gem configuration./).to_stdout
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

    describe "--config" do
      let(:command) { "--config" }
      it_behaves_like "a config command"
    end

    describe "-c" do
      let(:command) { "-c" }
      it_behaves_like "a config command"
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
