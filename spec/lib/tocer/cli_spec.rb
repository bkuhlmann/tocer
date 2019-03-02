# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI do
  describe ".start" do
    subject(:cli) { described_class.start command_line }

    let(:options) { [] }
    let(:command_line) { Array(command).concat options }

    shared_examples_for "a generate command" do
      let(:fixture_file) { File.join Bundler.root, "spec", "support", "fixtures", "missing.md" }
      let(:test_file) { File.join temp_dir, "README.md" }
      let(:contents) { IO.read test_file }
      before { FileUtils.cp fixture_file, test_file }

      context "with defaults", :temp_dir do
        it "generates table of contents" do
          ClimateControl.modify HOME: temp_dir.to_s do
            Dir.chdir temp_dir do
              cli
              expect(contents.include?("# Table of Contents")).to eq(true)
            end
          end
        end

        it "prints files processed" do
          ClimateControl.modify HOME: temp_dir.to_s do
            Dir.chdir temp_dir do
              message = "Processed table of contents for:\n" \
                        "  ./README.md\n"
              result = -> { cli }

              expect(&result).to output(message).to_stdout
            end
          end
        end
      end

      context "with custom label", :temp_dir do
        let(:label) { "# Index" }
        let(:options) { ["--label", label] }

        it "generates table of contents" do
          ClimateControl.modify HOME: temp_dir.to_s do
            Dir.chdir temp_dir do
              cli
              expect(contents.include?(label)).to eq(true)
            end
          end
        end
      end

      context "with custom include list", :temp_dir do
        let(:options) { ["--includes", ["*.txt"]] }
        let(:test_file) { File.join temp_dir, "test.txt" }

        before { FileUtils.touch File.join(temp_dir, "test.md") }

        it "generates table of contents" do
          ClimateControl.modify HOME: temp_dir.to_s do
            Dir.chdir temp_dir do
              cli
              expect(contents.include?("# Table of Contents")).to eq(true)
            end
          end
        end

        it "prints files processed" do
          ClimateControl.modify HOME: temp_dir.to_s do
            Dir.chdir temp_dir do
              message = "Processed table of contents for:\n" \
                        "  ./test.txt\n"
              result = -> { cli }

              expect(&result).to output(message).to_stdout
            end
          end
        end
      end

      context "with no files to process", :temp_dir do
        let(:options) { ["invalid.md"] }

        it "does not generate table of contents" do
          ClimateControl.modify HOME: temp_dir.to_s do
            Dir.chdir temp_dir do
              cli
              expect(contents.include?("# Table of Contents")).to eq(false)
            end
          end
        end

        it "prints nothing" do
          ClimateControl.modify HOME: temp_dir.to_s do
            Dir.chdir temp_dir do
              result = -> { cli }
              expect(&result).not_to output.to_stdout
            end
          end
        end
      end
    end

    shared_examples_for "an edit command" do
      let(:file_path) { File.join ENV["HOME"], Tocer::Identity.name }

      it "edits resource file", :temp_dir do
        ClimateControl.modify EDITOR: %(printf "%s\n") do
          Dir.chdir temp_dir do
            result = -> { cli }
            expect(&result).to output(/info\s+Editing\:\s#{file_path}\.\.\./).to_stdout
          end
        end
      end
    end

    shared_examples_for "a config command", :temp_dir do
      context "with no options" do
        it "prints help text" do
          result = -> { cli }
          expect(&result).to output(/Manage gem configuration./).to_stdout
        end
      end
    end

    shared_examples_for "a version command" do
      it "prints version" do
        result = -> { cli }
        expect(&result).to output(/#{Tocer::Identity.version_label}\n/).to_stdout
      end
    end

    shared_examples_for "a help command" do
      it "prints usage" do
        pattern = /#{Tocer::Identity.version_label}\scommands:\n/
        result = -> { cli }

        expect(&result).to output(pattern).to_stdout
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
