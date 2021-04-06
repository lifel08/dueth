class Instrument < ApplicationRecord
  belongs_to :user_id
  has_many :bookings
  has_one :cancellation_policy
  has_many :disponibilities
  validates :title, :sbubtitle, :location, :latitude, :longitude, :cancellation_policy; :price; presence: true
  # has_one_attached :photo
end
