class Flashcard < ApplicationRecord
  belongs_to :sentence
  belongs_to :deck, counter_cache: true
  accepts_nested_attributes_for :sentence
  acts_as_learnable
end
