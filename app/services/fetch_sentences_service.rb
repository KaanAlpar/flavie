class FetchSentencesService
  def self.call_api(conversion_url)
    video_id = CGI::parse(URI(conversion_url).query)["v"].first
    url = "http://video.google.com/timedtext?lang=en&v=#{video_id}"
    doc = Nokogiri::XML(RestClient.get(url).body)

    final = ""
    doc.xpath("//transcript/text").each do |e|
      final += " #{e.text}"
    end
    final.gsub!("\n", ' ')

    raise Conversion::MissingSubtitlesError if final == "" # No subtitles

    PragmaticSegmenter::Segmenter.new(text: final).segment
  end
end
