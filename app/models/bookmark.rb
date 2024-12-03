class Bookmark < ApplicationRecord
  has_many_attached :photos

  belongs_to :user
  belongs_to :route

  validates :user, uniqueness: { scope: :route,
    message: "sorry, already in your bookmark" }
end
