class FetchSentencesService
  def self.call_api(video_id, language)
    url = "http://video.google.com/timedtext?lang=#{language}&v=#{video_id}"
    doc = Nokogiri::XML(RestClient.get(url).body)

    raise Conversion::MissingSubtitlesError if doc.css("transcript text").empty?

    array_elements = doc.css("transcript text").map do |node|
      if language == 'ja'
        clean_content = node.children.text.gsub(' ', '.').gsub('  ', '.')
      else
        clean_content = node.children.text.gsub(/\n/, ' ').gsub(/\(.*?\)/, '').gsub(/\[.*?\]/, '').gsub('&quot;', '').gsub('&#39;', "'")
      end
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
  end
end
