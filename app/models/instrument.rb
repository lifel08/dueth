class Instrument < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings
  has_many :features, through: :instrument_features
  has_one :cancellation_policy
  validates :title, :subtitle, :location, :latitude, :longitude, :price, presence: true
  has_one_attached :photo

  include PgSearch::Model
    pg_search_scope :search_by_instrument_title_and_location,
   against: [ :title, :location ],
      using: {
        tsearch: { prefix: true }
      }
end
