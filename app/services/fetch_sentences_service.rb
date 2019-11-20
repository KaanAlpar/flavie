class FetchSentencesService
  def self.call_api(conversion_url)
    video_id = CGI::parse(URI(conversion_url).query)["v"]
    url = "http://video.google.com/timedtext?lang=en&v=#{video_id}"
    doc = Nokogiri::XML(open(url)).text
    sentences = []

    if doc != ""
      doc.split('.').each do |sentence|
        sentences << { content: sentence } unless sentence.blank?
      end
    else
      puts "This video does not have subtitles"
      raise
    end

    sentences
  end
end
