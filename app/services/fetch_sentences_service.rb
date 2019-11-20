class FetchSentencesService
  def self.call_api(conversion_url)
    video_id = CGI::parse(URI(conversion_url).query)["v"].first
    url = "http://video.google.com/timedtext?lang=en&v=#{video_id}"
    doc = Nokogiri::XML(RestClient.get(url).body).text.squish

    raise if doc == "" # No subtitles

    PragmaticSegmenter::Segmenter.new(text: doc).segment
  end
end
