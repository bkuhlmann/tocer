module Tocer
  # Builds table of contents for a document in Markdown.
  class Builder
    def initialize lines, label: "# Table of Contents", commenter: Commenter
      @lines = lines
      @label = label
      @commenter = commenter.new
    end

    def headers
      lines.select { |line| line.start_with? Header.punctuation }
    end

    def build
      return "" if headers.empty?

      content = "#{commenter.start}\n\n"
      content << "#{label}\n\n"
      content << headers_as_links.join("\n")
      content << "\n\n#{commenter.finish}\n\n"
    end

    private

    attr_reader :lines, :label, :commenter

    def transform header
      case
        when header =~ /\[.+\]\(.+\)/
          Transformers::Link.new(header).transform
        else
          Transformers::Text.new(header).transform
      end
    end

    def headers_as_links
      headers.map { |header| transform header }
    end
  end
end
