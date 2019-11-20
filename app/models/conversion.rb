class Conversion < ApplicationRecord
  belongs_to :user
  has_many :sentences, dependent: :destroy
  validates :url, presence: true
  validates :user, presence: true
  accepts_nested_attributes_for :sentences
end
