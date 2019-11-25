class FetchCountryCodeService
  def self.call(country_name)
    ISO_639.find_by_english_name(country_name)[2]
  end
end
