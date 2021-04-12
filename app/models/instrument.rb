class Instrument < ApplicationRecord
  geocoded_by :location
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings
  has_many :features, through: :instrument_features
  has_one :cancellation_policy
  validates :title, :subtitle, :location, :latitude, :longitude, :price, presence: true
  has_one_attached :photo
end
