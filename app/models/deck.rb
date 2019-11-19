class Deck < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy
  validates :name, presence: true
  validates :user, presence: true
  accepts_nested_attributes_for :flashcards
end
