class GetSentences
  def self.fetch_api_get_sentences(conversion_url)
    video_id = conversion_url.last(11)
    url = "http://video.google.com/timedtext?lang=en&v=#{video_id}"
    doc = Nokogiri::XML(open(url)).text
    sentences = []

    if doc != ""
      doc.split('.').each do |sentence|
        sentences << { content: sentence }
      end
    else
      puts "This video does not have subtitles"
      raise
    end

    sentences
  end
end
