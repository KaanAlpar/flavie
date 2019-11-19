module DecksHelper
  def get_sentence(id)
    Sentence.find(id)
  end
end
