class FetchSentencesService
  def self.call_api(conversion_url, video_id, lang)
    url = "http://video.google.com/timedtext?lang=#{lang}&v=#{video_id}"
    doc = Nokogiri::XML(RestClient.get(url).body)

    final = ""
    doc.xpath("//transcript/text").each do |e|
      final += " #{e.text}"
    end
    final.gsub!("\n", ' ')

    raise Conversion::MissingSubtitlesError if final == "" # No subtitles

    PragmaticSegmenter::Segmenter.new(text: final, language: lang).segment
  end
end
