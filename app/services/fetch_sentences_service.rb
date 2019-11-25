class FetchSentencesService
  def self.call_api(video_id)
    url = "http://video.google.com/timedtext?lang=en&v=#{video_id}"
    doc = Nokogiri::XML(RestClient.get(url).body)

    final = ""
    doc.xpath("//transcript/text").each do |e|
      final += " #{e.text}"
    end
    # not working
    # final.gsub!(/\(.*?\)/, '')
    # final.gsub!('&quot;', '"')
    # final.gsub!('&#39;', "'")
    # final.gsub!('\n', ' ')

    raise Conversion::MissingSubtitlesError if final == "" # No subtitles

    PragmaticSegmenter::Segmenter.new(text: final).segment
  end
end
