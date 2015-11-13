module Tocer
  # Transforms Markdown headers into anchored links.
  class Transformer
    def initialize text
      @text = text
    end

    def pounds
      String text[/\#{1,}/]
    end

    def label
      return "" if text.empty?
      text[pounds.length + 1, text.length].strip
    end

    def bullet
      return "" if pounds.empty?
      pounds_to_spaces(pounds).gsub(/\s{2}$/, "- ")
    end

    def url
      label.downcase.gsub(/\s/, "-").gsub(/[^\w\-\+\&]+/, "")
    end

    def transform
      "#{bullet}[#{label}](##{url})"
    end

    private

    attr_reader :text

    def pounds_to_spaces pounds
      Array.new(pounds.length, "  ").join
    end
  end
end
