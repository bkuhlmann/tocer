module Tocer
  # Builds table of contents for a document in Markdown.
  class Builder
    def initialize lines, label: "# Table of Contents", transformer: Transformer, commenter: Commenter
      @lines = lines
      @label = label
      @transformer = transformer
      @commenter = commenter.new
    end

    def headers
      lines.select { |line| line.start_with? "#" }
    end

    def build
      return "" if headers.empty?

      content = "#{commenter.start}\n\n"
      content << "#{label}\n\n"
      content << headers_as_links.join("\n")
      content << "\n\n#{commenter.finish}\n\n"
    end

    private

    attr_reader :lines, :label, :transformer, :commenter

    def headers_as_links
      headers.map { |header| transformer.new(header).transform }
    end
  end
end
