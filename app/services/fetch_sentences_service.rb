require 'rest-client'

class FetchSentencesService
  def self.call_api(conversion_url)
    video_id = CGI::parse(URI(conversion_url).query)["v"].first
    url = "http://video.google.com/timedtext?lang=en&v=#{video_id}"
    response = RestClient.get(url)
    doc = Nokogiri::XML(response.body).text.squish
    if doc != ""
      ps = PragmaticSegmenter::Segmenter.new(text: doc)
      sentences = ps.segment
    else
      puts "This video does not have subtitles"
      raise
    end

    sentences
  end
end
