# frozen_string_literal: true

RSpec.shared_examples_for "a parser" do
  describe ".call" do
    it "answers empty array" do
      expect(described_class.call(client: OptionParser.new, options: {a: 1})).to eq([])
    end
  end
end
