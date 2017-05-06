# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI do
  describe ".start" do
    let(:options) { [] }
    let(:command_line) { Array(command).concat options }
    let :cli do
      lambda do
        load "tocer/cli.rb" # Ensures clean Thor `.method_option` evaluation per spec.
        described_class.start command_line
      end
    end

    shared_examples_for "a generate command" do
      let(:fixture_file) { File.join Bundler.root, "spec", "support", "fixtures", "toc-missing.md" }
      let(:test_file) { File.join temp_dir, "README.md" }
      let(:contents) { IO.read test_file }
      before { FileUtils.cp fixture_file, test_file }

      context "with defaults", :temp_dir do
        it "generates table of contents" do
          ClimateControl.modify HOME: temp_dir do
            Dir.chdir temp_dir do
              cli.call
              expect(contents.include?("# Table of Contents")).to eq(true)
            end
          end
        end

        it "prints files processed" do
          ClimateControl.modify HOME: temp_dir do
            Dir.chdir temp_dir do
              message = "Processed table of contents for:\n" \
                        "  ./README.md\n"
              expect(&cli).to output(message).to_stdout
            end
          end
        end
      end

      context "with custom label", :temp_dir do
        let(:label) { "# Index" }
        let(:options) { ["--label", label] }

        it "generates table of contents" do
          ClimateControl.modify HOME: temp_dir do
            Dir.chdir temp_dir do
              cli.call
              expect(contents.include?(label)).to eq(true)
            end
          end
        end
      end

      context "with configured label", :temp_dir do
        let(:label) { "# Local" }
        let(:configuration_path) { File.join temp_dir, Tocer::Identity.file_name }
        before do
          File.open(configuration_path, "w") { |file| file.write %(:label: "#{label}") }
        end

        it "uses configured label" do
          ClimateControl.modify HOME: temp_dir do
            Dir.chdir(temp_dir) do
              cli.call
              expect(contents.include?(label)).to eq(true)
            end
          end
        end
      end

      context "with custom whitelist", :temp_dir do
        let(:options) { ["--whitelist", ["*.txt"]] }
        let(:test_file) { File.join temp_dir, "test.txt" }
        before { FileUtils.touch File.join(temp_dir, "test.md") }

        it "generates table of contents" do
          ClimateControl.modify HOME: temp_dir do
            Dir.chdir temp_dir do
              cli.call
              expect(contents.include?("# Table of Contents")).to eq(true)
            end
          end
        end

        it "prints files processed" do
          ClimateControl.modify HOME: temp_dir do
            Dir.chdir temp_dir do
              message = "Processed table of contents for:\n" \
                        "  ./test.txt\n"
              expect(&cli).to output(message).to_stdout
            end
          end
        end
      end

      context "with configured whitelist", :temp_dir do
        let(:test_file) { File.join temp_dir, "test.local" }
        let(:configuration_path) { File.join temp_dir, Tocer::Identity.file_name }
        before do
          File.open(configuration_path, "w") { |file| file.write %(:whitelist: [test.local]) }
        end

        it "uses configured whitelist" do
          ClimateControl.modify HOME: temp_dir do
            Dir.chdir(temp_dir) do
              cli.call
              expect(contents.include?("# Table of Contents")).to eq(true)
            end
          end
        end

        it "prints files processed" do
          ClimateControl.modify HOME: temp_dir do
            Dir.chdir temp_dir do
              message = "Processed table of contents for:\n" \
                        "  ./test.local\n"
              expect(&cli).to output(message).to_stdout
            end
          end
        end
      end

      context "with no files to process", :temp_dir do
        let(:options) { ["invalid.md"] }

        it "does not generate table of contents" do
          ClimateControl.modify HOME: temp_dir do
            Dir.chdir temp_dir do
              cli.call
              expect(contents.include?("# Table of Contents")).to eq(false)
            end
          end
        end

        it "prints nothing" do
          ClimateControl.modify HOME: temp_dir do
            Dir.chdir temp_dir do
              expect(&cli).to_not output.to_stdout
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
        pattern = /#{Tocer::Identity.label}\s#{Tocer::Identity.version}\scommands:\n/
        expect(&cli).to output(pattern).to_stdout
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
