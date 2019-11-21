class FetchTranslationService
  def self.call_api(keyword)
    url = "https://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{keyword}?key=#{ENV['DICTIONARY_API_KEY']}"
    response = Nokogiri::XML(RestClient.get(url).body)
    definitions = response.xpath('//dt')
    defs = []
    definitions.each do |definition|
      defs << definition
    end

    defs
  end
end
