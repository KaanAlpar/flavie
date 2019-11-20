class FetchSentencesService
  def self.call_api(conversion_url)
    video_id = CGI::parse(URI(conversion_url).query)["v"].first
    url = "http://video.google.com/timedtext?lang=en&v=#{video_id}"
    doc = Nokogiri::XML(RestClient.get(url).body)

    raise if doc == "" # No subtitles

    final = ""
    doc.xpath("//transcript/text").each do |e|
      final += " #{e.text}"
    end
    final.gsub!("\n", ' ')

    PragmaticSegmenter::Segmenter.new(text: final).segment
  end
end
