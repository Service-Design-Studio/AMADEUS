require 'pdf-reader'
require 'json'

class ExtractPdf
  @stop_words = ["More on this story", "Related Topics", "Top stories"]

  def self.get_pdf_text(pdf)
    content = ""
    reader = PDF::Reader.new(StringIO.new(pdf.get_input_stream.read))
    reader.pages.each do |page|
      result = extract_main_text(page.text)
      text = clean_text(result[:text])
      content.concat(text)
      if result[:status] == "finished"
        break
      end
    end
    return content.to_json
  end

  def self.extract_main_text(text)
    indices = Array.new
    sentence_ls = text.split("\n")

    # Trim end of articles based on Suggested readings prom
    @stop_words.each do |stop_word|
      idx = sentence_ls.index { |s| s.include?(stop_word) }
      idx.nil? ? next : indices << idx
    end
    # If found end of articles, trim and early return
    threshold_idx = indices.min
    unless threshold_idx.nil?
      sentence_ls.drop(threshold_idx - 1)
      return { text: text, status: "finished" }
    end

    # Remove standalone word from navbar or sidebar
    sentence_ls = trim_standalone_word(sentence_ls)
    text = sentence_ls.join("")
    return { text: text, status: "continue" }
  end

  def self.trim_standalone_word(sentence_ls)
    sentence_ls.each do |sentence|
      # if have punctuation, more likely to be a sentence so skip
      if sentence.match(/[.!?]/)
        next
      end
      # else filter out sentence that mostly capital letter
      capital_count = sentence.scan(/[A-Z]/).length
      if capital_count > 0.5 * sentence.split.size
        sentence_ls.delete_at(sentence_ls.index(sentence))
      end
    end
    sentence_ls
  end

  def self.clean_text(text)
    text = text.strip.delete("\t\r\n") # strip whitespace
    text = text.gsub(/[^\x00-\x7F]/, " ") # strip non-ASCII
    text = text.gsub(/(?<=[.,?!;])(?=[^\s])/, " ") # add whitespace after punctuation
    text = text.gsub(/\s+(?=\d)/, "") # remove whitespace added between number
    text = text.gsub(/(?<=[a-z1-9])(?=[A-Z])/, " ") # add whitespace before capital letter
    text = text.gsub(/(?<=[a-zA-Z])(?=\d)/, " ") # add whitespace after number
    text.squeeze(' ')
  end
end