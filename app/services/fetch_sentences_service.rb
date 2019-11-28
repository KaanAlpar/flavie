class FetchSentencesService
  def self.call_api(video_id, language)
    url = "http://video.google.com/timedtext?lang=#{language}&v=#{video_id}"
    doc = Nokogiri::XML(RestClient.get(url).body)

    raise Conversion::MissingSubtitlesError if doc.css("transcript text").empty?

    if language == 'en'
      array_elements = doc.css("transcript text").map do |node|
        clean_content = node.children.text.gsub(/\n/, ' ').gsub(/\(.*?\)/, '').gsub(/\[/, '').gsub(/\]/, '').gsub('&quot;', '').gsub('&#39;', "'")
        { start: node.attributes['start'].value, content: clean_content }
      end

      array_elements.delete_if {|hash| hash[:content].blank? }

      sentences_array = array_elements.map do |hash_sentence|
        "[#{hash_sentence[:start]}] #{hash_sentence[:content]}"
      end

      segmented = PragmaticSegmenter::Segmenter.new(text: sentences_array.join(" ")).segment

      prev = nil
      segmented.map do |sentence|
        regex_match = sentence.match(/\[\d*?\.?\d*?\]/)

        prev = regex_match[0].gsub(/\[|\]/, '') if regex_match.present?
        {
          start_timestamp: prev,
          content: sentence.gsub(/\[\d*?\.?\d*?\] /, '').strip
        }
      end
    elsif language == 'ja'
      # sentence_endings = ['ます', 'ません', 'ましょう', 'ませんでした', 'ました', 'よ', 'よね', 'です', '？', '！', '。', '', '', '', '', '', '', '', '', '']
      array_elements = doc.css("transcript text").map do |node|
        clean_content = node.children.text.gsub(/\n/, ' ')
        clean_content += "。"
        { start: node.attributes['start'].value, content: clean_content }
      end

      array_elements.delete_if {|hash| hash[:content].blank? }

      sentences_array = array_elements.map do |hash_sentence|
        "[#{hash_sentence[:start]}] #{hash_sentence[:content]}"
      end

      segmented = PragmaticSegmenter::Segmenter.new(text: sentences_array.join(" "), language: 'ja').segment
      prev = nil
      segmented.map do |sentence|
        sentence.gsub!('。', ' ')
        regex_match = sentence.match(/\[\d*?\.?\d*?\]/)

        prev = regex_match[0].gsub(/\[|\]/, '') if regex_match.present?
        {
          start_timestamp: prev,
          content: sentence.gsub(/\[\d*?\.?\d*?\] /, '').strip
        }
      end
    end
  end
end
