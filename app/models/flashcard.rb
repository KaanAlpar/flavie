class Flashcard < ApplicationRecord
  belongs_to :sentence
  belongs_to :deck
  acts_as_learnable
end
