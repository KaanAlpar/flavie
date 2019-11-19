require 'open-uri'

class Conversion < ApplicationRecord
  belongs_to :user
  has_many :sentences, dependent: :destroy
  validates :url, presence: true
  validates :user, presence: true
  accepts_nested_attributes_for :sentences

  after_create :fetch_api_get_sentences
end
