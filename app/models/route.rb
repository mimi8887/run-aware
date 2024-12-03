class Route < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :runs
  has_many :steps
  has_many :bookmarks
end
