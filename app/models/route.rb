class Route < ApplicationRecord
  belongs_to :step
  belongs_to :user
  has_many :runs
  has_many :steps
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
