class Sentence < ApplicationRecord
  belongs_to :conversion
  has_many :flashcards, dependent: :destroy
  validates :content, presence: true
end
