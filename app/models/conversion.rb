class Conversion < ApplicationRecord
  belongs_to :user
  has_many :sentences, dependent: :destroy
  validates :url, presence: true
  validates :user, presence: true
  # validates :video_title, presence: true
end
