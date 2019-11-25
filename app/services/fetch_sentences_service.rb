class FetchSentencesService
  def self.call_api(video_id)
    url = "http://video.google.com/timedtext?lang=en&v=#{video_id}"
    doc = Nokogiri::XML(RestClient.get(url).body)

    final = ""
    doc.xpath("//transcript/text").each do |e|
      final += " #{e.text}"
    end
    raise Conversion::MissingSubtitlesError if final == "" # No subtitles

    final.gsub!(/\n/, ' ')
    final.gsub!(/\(.*?\)/, '')

    segmented = PragmaticSegmenter::Segmenter.new(text: final).segment

    segmented.each do |sentence|
      sentence.gsub!('&quot;', '')
      sentence.gsub!('&#39;', "'")
    end

    segmented
  end
end
