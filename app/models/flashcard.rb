class Flashcard < ApplicationRecord
  belongs_to :sentence
  belongs_to :deck, counter_cache: true
  acts_as_learnable
end
