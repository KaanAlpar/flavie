class FetchSentencesService
  def self.call_api(video_id, lang)
    url = "http://video.google.com/timedtext?lang=#{lang}&v=#{video_id}"
    doc = Nokogiri::XML(RestClient.get(url).body)

    if lang == 'en'
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

      PragmaticSegmenter::Segmenter.new(text: final, language: lang).segment
    else
      final = []
      doc.xpath("//transcript/text").each do |e|
        final << e.text
      end
      raise Conversion::MissingSubtitlesError if final == [] # No subtitles

      final.each do |s|
        s.gsub!("\n", ' ')
      end
      final
    end
  end
end
