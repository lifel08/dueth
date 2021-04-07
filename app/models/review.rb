class Review < ApplicationRecord
  belongs_to :bookings
  has_one :user, through: :booking
  has_one :instrument, through: :booking
  validates :content, :booking, presence: true
  validates :rating, inclusion: { in: 0..5 }, numericality: { only_integer: true }
end


