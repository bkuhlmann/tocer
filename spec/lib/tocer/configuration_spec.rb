require "spec_helper"

describe Tocer::Configuration, :temp_dir do
  subject { described_class.new }

  describe "#label" do
    subject { described_class.new }

    context "with default resource file" do
      it "answers default label" do
        ClimateControl.modify HOME: temp_dir do
          expect(subject.label).to eq("# Table of Contents")
        end
      end
    end

    context "with custom resource file" do
      let(:file_path) { File.join temp_dir, ".testrc" }
      subject { described_class.new file_path: file_path }
      before { File.open(file_path, "w") { |file| file.write ":label: Custom Label\n" } }

      it "answers custom label" do
        expect(subject.label).to eq("Custom Label")
      end
    end

    context "with overwritten settings" do
      it "answers custom label" do
        subject.label = "Overwritten Label"
        expect(subject.label).to eq("Overwritten Label")
      end
    end
  end
end
