require 'uri'
require 'net/http'
require 'openssl'

class FetchTranslationService
  def self.call_api(keyword, lang)
    if lang == 'en'
      url = URI("https://wordsapiv1.p.rapidapi.com/words/#{keyword}/definitions")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-host"] = 'wordsapiv1.p.rapidapi.com'
      request["x-rapidapi-key"] = ENV['WORDS_API_KEY']

      response = JSON.parse(http.request(request).read_body)
      response['definitions'].map { |d| d['definition'] }
    else
      url = "https://jisho.org/api/v1/search/words?keyword=#{keyword}"
      doc = JSON.parse(RestClient.get(url).body)
      doc['data'].first['senses'].map do |d|
        d['english_definitions'].map do |ed|
          ed
        end
      end
    end
  end
end
