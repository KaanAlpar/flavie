class FetchSentencesService
  def self.call_api(video_id, language)
    url = "http://video.google.com/timedtext?lang=#{language}&v=#{video_id}"
    doc = Nokogiri::XML(RestClient.get(url).body)

    final = ""
    doc.xpath("//transcript/text").each do |e|
      final += " #{e.text}"
    end
    raise Conversion::MissingSubtitlesError if final == " " # No subtitles

    final.gsub!(/\n/, ' ')
    final.gsub!(/\(.*?\)/, '')
    final.gsub!('-- ', '')

    if language == 'ja'
      final.gsub!(' ', '.')
      final.gsub!('　', '.')
    end

    segmented = PragmaticSegmenter::Segmenter.new(text: final).segment

    segmented.each do |sentence|
      sentence.gsub!('&quot;', '')
      sentence.gsub!('&#39;', "'")
    end

    segmented
  end
end
