class Bookmark < ApplicationRecord
  has_one_attached :photo

  belongs_to :user
  belongs_to :route
end
