class Route < ApplicationRecord
  belongs_to :user
  has_many :runs
  has_many :steps
end
